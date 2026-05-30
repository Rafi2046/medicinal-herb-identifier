import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static String apiUrl =
      "https://ishmakrahatrafi-herb-backend.hf.space/predict";

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  static Future<Map<String, dynamic>> uploadAndPredict(
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
        if (confidenceThreshold != null)
          "confidence_threshold": confidenceThreshold,
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

        return {"success": true, "data": response.data};
      } else {
        return {
          "success": false,
          "message": "Server returned an error status: ${response.statusCode}",
        };
      }
    } on DioException catch (e) {
      String errorMessage =
          "Failed to connect to the server. Please try again later.";

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        errorMessage =
            "Server is taking too long to respond. Hugging Face might be waking up, please try again.";
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown && e.error is SocketException) {
        errorMessage =
            "No Internet Connection! Please check your WiFi or Mobile Data.";
      }

      if (kDebugMode) {
        debugPrint("Dio Network Error: $errorMessage (type: ${e.type})");
      }

      return {"success": false, "message": errorMessage};
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Exception during API call: $e");
      }
      return {
        "success": false,
        "message": "An unexpected error occurred. Please try again.",
      };
    }
  }
}
