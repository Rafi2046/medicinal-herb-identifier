import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';

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
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return {'success': false, 'message': null};
    }

    final croppedPath = await cropImage(image.path);
    if (croppedPath == null) {
      return {'success': false, 'message': 'Cropping cancelled'};
    }

    return processPickedImage(croppedPath);
  }

  Future<Map<String, dynamic>> processPickedImage(String imagePath) async {
    try {
      _lastImagePath = imagePath;
      _isLoading = true;
      notifyListeners();

      final resultMap = await ApiService.uploadAndPredict(File(imagePath));

      _isLoading = false;

      if (resultMap['success'] == true) {
        final apiData = resultMap['data'];
        final predictionResult = PredictionResult.fromJson(apiData);

        if (predictionResult.primaryConfidence < 0.45) {
          _lastResult = {
            'success': false,
            'message':
                'No clear leaf detected. Please crop the image or capture a better photo.',
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
        'message': 'An unexpected error occurred while processing the image.',
      };
      notifyListeners();
      return _lastResult!;
    }
  }

  Future<Map<String, dynamic>> reprocessWithThreshold(double threshold) async {
    _confidenceThreshold = threshold;
    if (_lastImagePath == null) {
      return {'success': false, 'message': 'No image to reprocess.'};
    }

    notifyListeners();
    return {'success': true};
  }
}
