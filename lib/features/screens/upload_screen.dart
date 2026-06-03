import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medical_herb/features/screens/widgets/screen_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/screens/widgets/screen_guide_bottom_sheet.dart';
import 'package:medical_herb/features/common_widgets/toast_utils.dart';
import 'package:medical_herb/features/screens/widgets/zoom_in_zoom_out_widget.dart';

class UploadScreen extends StatefulWidget {
  final String? imagePath;
  final PredictionResult? predictionResult;

  const UploadScreen({super.key, this.imagePath, this.predictionResult});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey _cropKey = GlobalKey();
  String? _originalImagePath;

  Future<void> _reprocess(BuildContext context) async {
    final provider = context.read<ScanProvider>();
    final result = await provider.reprocessWithThreshold(
      provider.confidenceThreshold,
    );
    if (!context.mounted) return;
    if (result['success'] != true) {
      ToastUtils.error(
        result['message'] as String? ?? 'Reprocess failed',
      );
    }
  }

  Future<void> _captureAndScan(BuildContext context) async {
    final boundary =
        _cropKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    final result = await context.read<ScanProvider>().processCroppedBoundary(
      boundary,
    );

    if (!context.mounted) return;
    Navigator.pop(context);

    if (result['success'] == true) {
      final predictionResult = result['predictionResult'] as PredictionResult;
      context.read<HistoryProvider>().addScan(
        predictionResult.primaryPrediction,
        predictionResult.primaryConfidence,
        ScanSource.camera,
      );
    } else {
      ToastUtils.error(
        result['message'] as String? ?? 'Scan failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      body: Consumer<ScanProvider>(
        builder: (context, scanProvider, _) {
          _originalImagePath ??= widget.imagePath ?? scanProvider.lastImagePath;
          final lastResult = scanProvider.lastResult;
          final result = lastResult != null && lastResult['success'] == true
              ? lastResult['predictionResult'] as PredictionResult
              : widget.predictionResult;

          final primaryName = result?.primaryPrediction ?? 'Unknown';
          final confidence = (result?.primaryConfidence ?? 0.0) * 100;
          final allPredictions = result?.top3 ?? [];
          final otherPredictions =
              allPredictions.where((p) => p.className != primaryName).toList()
                ..sort((a, b) => b.confidence.compareTo(a.confidence));
          final topPredictions = otherPredictions.take(3).toList();

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.55,
                child: _originalImagePath != null
                    ? ZoomInZoomOutWidget(
                        imagePath: _originalImagePath!,
                        cropKey: _cropKey,
                        onScan: () => _captureAndScan(context),
                      )
                    : const SizedBox.shrink(),
              ),

              Positioned(
                top: paddingTop + 12,
                left: 16,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: paddingTop + 12,
                right: 16,
                child: InkWell(
                  onTap: () => ScanGuideBottomSheet.show(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: size.height * 0.50,
                left: 0,
                right: 0,
                bottom: 0,
                child: ScanBottomSheetWidget(
                  primaryName: primaryName,
                  confidence: confidence,
                  topPredictions: topPredictions,
                  totalPredictions: allPredictions.length,
                  scanProvider: scanProvider,
                  onReprocess: _reprocess,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
