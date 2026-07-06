import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:image/image.dart' as img;

class ScanProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _lastImagePath;
  Map<String, dynamic>? _lastResult;
  double _confidenceThreshold = 0.40;

  bool get isLoading => _isLoading;

  String? get lastImagePath => _lastImagePath;

  Map<String, dynamic>? get lastResult => _lastResult;

  double get confidenceThreshold => _confidenceThreshold;

  set confidenceThreshold(double value) {
    _confidenceThreshold = value;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  Future<String?> _copyToPermanentStorage(String sourcePath) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'leaf_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(sourcePath);
      final permanent = await file.copy('${dir.path}/$fileName');
      return permanent.path;
    } catch (e) {
      debugPrint('Error copying to permanent storage: $e');
      return null;
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

    final permanentPath = await _copyToPermanentStorage(image.path);
    if (permanentPath == null) {
      return {'success': false, 'message': 'Failed to save image'};
    }

    final croppedPath = await cropImage(permanentPath);
    final finalPath = croppedPath ?? permanentPath;

    return processPickedImage(finalPath);
  }

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

      final dir = await getApplicationDocumentsDirectory();
      File tempFile = File(
        '${dir.path}/cropped_leaf_${DateTime.now().millisecondsSinceEpoch}.png',
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

  Future<Map<String, dynamic>> processPickedImage(String imagePath) async {
    try {
      _lastImagePath = imagePath;
      final permanentPath = await _copyToPermanentStorage(imagePath);
      final workingPath = permanentPath ?? imagePath;
      _lastImagePath = workingPath;
      _isLoading = true;
      notifyListeners();

      final qualityCheck = await compute(_checkImageQuality, workingPath);

      if (qualityCheck['isValid'] == false) {
        _isLoading = false;
        _lastResult = {'success': false, 'message': qualityCheck['message']};
        notifyListeners();
        return _lastResult!;
      }

      // FIX: actually forward the user-adjustable threshold to the backend.
      // Before, this was never passed, so the slider had no real effect.
      final resultMap = await ApiService.uploadAndPredict(
        File(workingPath),
        confidenceThreshold:
        _confidenceThreshold > 0 ? _confidenceThreshold : null,
      );

      _isLoading = false;

      if (resultMap['success'] == true) {
        final apiData = resultMap['data'];
        final predictionResult = PredictionResult.fromJson(apiData);

        if (kDebugMode) {
          debugPrint(
            " Model Predicted: ${predictionResult.primaryPrediction}",
          );
          debugPrint(
            " Confidence Score: ${predictionResult.primaryConfidence}",
          );
        }

        // FIX: backend confidence is on a 0-100 scale, not 0-1, so comparing
        // it to 0.20 never actually triggered. Use the backend's own
        // is_known flag instead - it already applies the correct threshold.
        if (!predictionResult.isKnown) {
          _lastResult = {
            'success': false,
            'message':
            'Low confidence. Try a clearer photo or different leaf.',
          };
        } else {
          _lastResult = {
            'success': true,
            'imagePath': workingPath,
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
    } catch (e, stackTrace) {
      debugPrint("========== JSON PARSING ERROR ==========");
      debugPrint("ERROR: $e");
      debugPrint("STACKTRACE: $stackTrace");
      debugPrint("========================================");

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
    // NOTE: this only updates the stored threshold; it does not actually
    // re-run prediction. If you want changing the slider to re-score the
    // same image with the new threshold, call processPickedImage(_lastImagePath!)
    // here instead of just returning success.
    return {'success': true};
  }
}

Map<String, dynamic> _checkImageQuality(String imagePath) {
  try {
    final file = File(imagePath);
    final bytes = file.readAsBytesSync();

    img.Image? decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) return {'isValid': true};

    img.Image thumbnail = img.copyResize(decodedImage, width: 50);

    double totalBrightness = 0.0;
    int greenPixelCount = 0;
    int pixelCount = thumbnail.width * thumbnail.height;

    for (var p in thumbnail) {
      double luminance = (0.299 * p.r) + (0.587 * p.g) + (0.114 * p.b);
      totalBrightness += luminance;

      // Excess Green Check
      if (p.g > p.r + 15 && p.g > p.b + 15) {
        greenPixelCount++;
      }
    }

    double avgBrightness = totalBrightness / pixelCount;
    double greenPercentage = (greenPixelCount / pixelCount) * 100;

    if (kDebugMode) {
      debugPrint("Image Brightness: $avgBrightness");
      debugPrint(" Green Pixel Percentage: $greenPercentage%");
    }
    // Completely dark (like covering the lens with a finger)
    if (avgBrightness < 15.0) {
      return {'isValid': false, 'message': 'Too dark. Please use flash.'};
    }

    if (avgBrightness < 60.0 && greenPercentage < 5.0) {
      return {
        'isValid': false,
        'message': 'Too dark and no leaf detected. Scan in well-lit area.'
      };
    }

    if (greenPercentage < 5.0) {
      return {
        'isValid': false,
        'message': 'No leaf detected. Please scan a medicinal leaf.'
      };
    }

    return {'isValid': true};
  } catch (e) {
    return {'isValid': true};
  }
}