import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/common_widgets/toast_utils.dart';
import 'package:medical_herb/features/screens/upload_screen.dart';

class ScanHelper {
  static Future<void> pickAndProcess(
    BuildContext context,
    ImageSource source,
  ) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null || !context.mounted) return;

    final provider = context.read<ScanProvider>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await provider.processPickedImage(image.path);

    if (!context.mounted) return;

    Navigator.pop(context);

    final scanSource = source == ImageSource.camera
        ? ScanSource.camera
        : ScanSource.gallery;
    _handleResult(context, result, scanSource);
  }

  static void _handleResult(
    BuildContext context,
    Map<String, dynamic> result,
    ScanSource source,
  ) {
    if (result['success'] == true) {
      final imagePath = result['imagePath'] as String;
      final predictionResult = result['predictionResult'] as PredictionResult;
      final herbName = predictionResult.primaryPrediction;
      final confidence = predictionResult.primaryConfidence;

      context.read<HistoryProvider>().addScan(herbName, confidence, source);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UploadScreen(
            imagePath: imagePath,
            predictionResult: predictionResult,
          ),
        ),
      );
    } else {
      final message =
          result['message'] as String? ?? 'Failed to identify plant.';
      ToastUtils.error(message);
    }
  }
}
