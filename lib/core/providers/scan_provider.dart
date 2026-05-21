// lib/core/providers/scan_provider.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';

class ScanProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ImagePicker _picker = ImagePicker();


  Future<Map<String, dynamic>?> processImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null; // ইউজার ছবি না তুললে ব্যাক করবে

      _isLoading = true;
      notifyListeners();

      final resultData = await ApiService.uploadAndPredict(File(image.path));

      _isLoading = false;
      notifyListeners();

      // রেজাল্ট প্রোসেস করে UI এর জন্য পাঠানো
      if (resultData != null) {
        if (resultData['status'] == 'success') {
          return {
            'success': true,
            'imagePath': image.path,
            'predictionResult': PredictionResult.fromJson(resultData),
          };
        } else if (resultData['status'] == 'unknown') {
          return {
            'success': false,
            'message': resultData['message'] ?? 'Unknown leaf detected!',
          };
        }
      }
      return {
        'success': false,
        'message': 'Failed to connect to the server. Is the API running?',
      };
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