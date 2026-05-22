import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {

  static String apiUrl = "https://ishmakrahatrafi-herb-backend.hf.space/predict";
  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>?> uploadAndPredict(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      Response response = await _dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("API Error: Status Code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception during API call: $e");
      return null;
    }
  }
}