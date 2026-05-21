import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';

class ScanProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ImagePicker _picker = ImagePicker();

  Future<Map<String, dynamic>> processImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return {'success': false, 'message': null};
    }
    return processPickedImage(image.path);
  }

  Future<Map<String, dynamic>> processPickedImage(String imagePath) async {
    try {
      _isLoading = true;
      notifyListeners();

      final resultData = await ApiService.uploadAndPredict(File(imagePath));

      _isLoading = false;
      notifyListeners();

      if (resultData != null && resultData['status'] == 'success') {
        return {
          'success': true,
          'imagePath': imagePath,
          'predictionResult': PredictionResult.fromJson(resultData),
        };
      } else if (resultData != null && resultData['status'] == 'unknown') {
        return {
          'success': false,
          'message': resultData['message'] ?? 'Unknown leaf detected!',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to connect to the server. Is the API running?',
        };
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
