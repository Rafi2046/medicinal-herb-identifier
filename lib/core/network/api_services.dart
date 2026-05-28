import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static String apiUrl =
      "https://ishmakrahatrafi-herb-backend.hf.space/predict";

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 60),
    ),
  );

  static Future<Map<String, dynamic>?> uploadAndPredict(
    File imageFile, {
    double? confidenceThreshold,
  }) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        "confidence_threshold": ?confidenceThreshold,
      });

      if (kDebugMode) {
        debugPrint("Uploading image to server...");
      }

      Response response = await _dio.post(
        apiUrl,
        data: formData,
        options: Options(headers: {"Accept": "application/json"}),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          debugPrint(
            "Prediction Success: ${response.data['primary_prediction']}",
          );
        }
        return response.data;
      } else {
        if (kDebugMode) {
          debugPrint("API Error: Status Code ${response.statusCode}");
        }
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint("Dio Network Error: ${e.message} (type: ${e.type})");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Exception during API call: $e");
      }
      return null;
    }
  }
}
