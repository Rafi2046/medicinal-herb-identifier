import 'dart:io';
import 'package:flutter/foundation.dart'; // 🛠️ compute() এর জন্য এটি লাগবে
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';

// 🛠️ পিক্সেল রিড করার জন্য image প্যাকেজটি ইম্পোর্ট করুন
import 'package:image/image.dart' as img;

class ScanProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _lastImagePath;
  Map<String, dynamic>? _lastResult;
  double _confidenceThreshold = 0.0;

  bool get isLoading => _isLoading;
  String? get lastImagePath => _lastImagePath;
  Map<String, dynamic>? get lastResult => _lastResult;
  double get confidenceThreshold => _confidenceThreshold;

  set confidenceThreshold(double value) {
    _confidenceThreshold = value;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  Future<String?> cropImage(String imagePath) async {
    // ... আপনার আগের ক্রপ ইমেজের কোড ...
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Leaf Image',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Leaf Image',
            aspectRatioLockEnabled: false,
          ),
        ],
      );
      return croppedFile?.path;
    } catch (e) {
      debugPrint('Crop error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> processImage(ImageSource source) async {
    // ... আপনার আগের প্রসেস ইমেজের কোড ...
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return {'success': false, 'message': null};

    final croppedPath = await cropImage(image.path);
    if (croppedPath == null) return {'success': false, 'message': 'Cropping cancelled'};

    return processPickedImage(croppedPath);
  }

  Future<Map<String, dynamic>> processPickedImage(String imagePath) async {
    try {
      _lastImagePath = imagePath;
      _isLoading = true;
      notifyListeners();

      // 💡 ম্যাজিক: API-তে পাঠানোর আগেই ব্রাইটনেস চেক!
      final isTooDark = await compute(_isImageTooDark, imagePath);

      if (isTooDark) {
        _isLoading = false;
        _lastResult = {
          'success': false,
          'message': 'Image is too dark! Please scan in a well-lit area or use flash.',
        };
        notifyListeners();
        return _lastResult!;
      }

      // 🛠️ যদি ছবি ঠিক থাকে, তাহলে API কল হবে
      final resultMap = await ApiService.uploadAndPredict(File(imagePath));

      _isLoading = false;

      // 💡 ডাবল নেস্টিং ক্লিন করা হলো
      if (resultMap['success'] == true) {
        final apiData = resultMap['data'];
        final predictionResult = PredictionResult.fromJson(apiData);

        // 💡 ম্যাজিক ফিক্স: 60.0 এর বদলে 0.60 (কারণ API 0 থেকে 1 এর মধ্যে ডেটা দেয়)
        if (predictionResult.primaryConfidence < 0.60) {
          _lastResult = {
            'success': false,
            'message': 'No valid leaf detected! Please scan a clear leaf image.',
          };
        } else {
          _lastResult = {
            'success': true,
            'imagePath': imagePath,
            'predictionResult': predictionResult,
          };
        }
      } else {
        _lastResult = {
          'success': false,
          'message': resultMap['message'] ?? 'Failed to connect to the server.',
        };
      }

      notifyListeners();
      return _lastResult!;
    } catch (e) {
      _isLoading = false;
      _lastResult = {
        'success': false,
        'message': 'An unexpected error occurred while processing the image.'
      };
      notifyListeners();
      return _lastResult!;
    }
  }

  Future<Map<String, dynamic>> reprocessWithThreshold(double threshold) async {
    _confidenceThreshold = threshold;
    if (_lastImagePath == null) return {'success': false, 'message': 'No image to reprocess.'};
    notifyListeners();
    return {'success': true};
  }
}

// 💡 আইসোলেটের (Isolate) জন্য টপ-লেভেল ফাংশন (ক্লাসের বাইরে রাখতে হবে)
bool _isImageTooDark(String imagePath) {
  try {
    final file = File(imagePath);
    final bytes = file.readAsBytesSync();

    // ছবি ডিকোড করা হলো
    img.Image? decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) return false;

    // প্রসেসিং ফাস্ট করার জন্য ছবিটাকে একদম ছোট (50x50) করে নিচ্ছি
    img.Image thumbnail = img.copyResize(decodedImage, width: 50);

    double totalBrightness = 0.0;
    int pixelCount = thumbnail.width * thumbnail.height;

    // প্রতিটি পিক্সেলের ব্রাইটনেস চেক করা হচ্ছে
    for (var p in thumbnail) {
      // কালার সায়েন্সের লুমিন্যান্স (Luminance) ফর্মুলা
      double luminance = (0.299 * p.r) + (0.587 * p.g) + (0.114 * p.b);
      totalBrightness += luminance;
    }

    double avgBrightness = totalBrightness / pixelCount;

    // 0 মানে পিওর ব্ল্যাক, 255 মানে পিওর হোয়াইট।
    // যদি এভারেজ ব্রাইটনেস 15 এর নিচে হয়, তার মানে ছবি অতিরিক্ত কালো।
    return avgBrightness < 15.0;
  } catch (e) {
    return false; // কোনো এরর হলে স্কিপ করে API-তে পাঠিয়ে দেবে
  }
}