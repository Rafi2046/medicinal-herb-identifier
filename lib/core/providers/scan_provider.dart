import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<Map<String, dynamic>> processCroppedBoundary(
    RenderRepaintBoundary boundary,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      File tempFile = File(
        '${tempDir.path}/cropped_leaf_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await tempFile.writeAsBytes(pngBytes);

      return await processPickedImage(tempFile.path);
    } catch (e) {
      _isLoading = false;
      _lastResult = {
        'success': false,
        'message': 'Failed to process crop area: $e',
      };
      notifyListeners();
      return _lastResult!;
    }
  }

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
    if (image == null) return {'success': false, 'message': null};

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

      final isTooDark = await compute(_isImageTooDark, imagePath);

      if (isTooDark) {
        _isLoading = false;
        _lastResult = {
          'success': false,
          'message':
              'Image is too dark! Please scan in a well-lit area or use flash.',
        };
        notifyListeners();
        return _lastResult!;
      }

      final resultMap = await ApiService.uploadAndPredict(File(imagePath));

      _isLoading = false;

      if (resultMap['success'] == true) {
        final apiData = resultMap['data'];
        final predictionResult = PredictionResult.fromJson(apiData);

        if (predictionResult.primaryConfidence < 0.50) {
          _lastResult = {
            'success': false,
            'message':
                'No valid leaf detected! Please scan a clear leaf image.',
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

bool _isImageTooDark(String imagePath) {
  try {
    final file = File(imagePath);
    final bytes = file.readAsBytesSync();

    img.Image? decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) return false;

    img.Image thumbnail = img.copyResize(decodedImage, width: 50);

    double totalBrightness = 0.0;
    int pixelCount = thumbnail.width * thumbnail.height;

    for (var p in thumbnail) {
      double luminance = (0.299 * p.r) + (0.587 * p.g) + (0.114 * p.b);
      totalBrightness += luminance;
    }

    double avgBrightness = totalBrightness / pixelCount;
    return avgBrightness < 15.0;
  } catch (e) {
    return false;
  }
}
