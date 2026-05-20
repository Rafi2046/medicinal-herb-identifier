import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  static const String apiUrl = "http://10.0.2.2:8000/predict";

  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>?> uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      print("🚀 Sending image to AI Backend via Dio...");

      Response response = await _dio.post(
        apiUrl,
        data: formData,

        options: Options(
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200) {
        print("✅ AI Response: ${response.data}");
        return response.data;
      } else {
        print("❌ Server Error: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("⚠️ Dio API Error: ${e.message}");
      if (e.response != null) {
        print("Server Data: ${e.response?.data}");
      }
      return null;
    } catch (e) {
      print("⚠️ Unknown Error: $e");
      return null;
    }
  }
}
