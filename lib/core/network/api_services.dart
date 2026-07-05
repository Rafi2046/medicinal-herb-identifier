import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static const String apiUrl = "https://nearness-usage-possibly.ngrok-free.dev";

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: Duration(minutes: 5),
      receiveTimeout: Duration(minutes: 5),
      sendTimeout: Duration(minutes: 5),
      headers: {
        "Accept": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
    ),
  );

  static Future<Map<String, dynamic>> uploadAndPredict(
      File imageFile, {
        double? confidenceThreshold,
      }) async {
    try {
      final String fileName = imageFile.path.split('/').last;

      // IMPORTANT: backend route is /predict, not the bare root URL
      final String endpoint = "$apiUrl/predict";

      debugPrint("Posting to: $endpoint");
      debugPrint("Image: ${imageFile.path}");

      FormData formData = FormData.fromMap({
        // backend expects the file under the key "image"
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        // backend expects this field named "threshold"
        if (confidenceThreshold != null)
          "threshold": confidenceThreshold,
      });

      Response response = await _dio.post(endpoint, data: formData);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200) {
        return {"success": true, "data": response.data};
      }

      return {
        "success": false,
        "message": "Server returned status code ${response.statusCode}",
      };
    } on DioException catch (e) {
      debugPrint("========== DIO ERROR ==========");
      debugPrint("TYPE: ${e.type}");
      debugPrint("MESSAGE: ${e.message}");
      debugPrint("ERROR: ${e.error}");
      debugPrint("RESPONSE: ${e.response?.data}");
      debugPrint("===============================");

      String errorMessage = "Failed to connect to server.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          errorMessage =
          "Server timeout. The model server may still be loading or waking up.";
          break;

        case DioExceptionType.connectionError:
          errorMessage = "Connection error. Check your internet connection.";
          break;

        case DioExceptionType.badResponse:
          errorMessage = "Server error: ${e.response?.statusCode}";
          break;

        default:
          errorMessage = e.message ?? "Unknown error occurred.";
      }

      return {"success": false, "message": errorMessage};
    } catch (e) {
      debugPrint("GENERAL ERROR: $e");

      return {"success": false, "message": e.toString()};
    }
  }
}