import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';
import 'package:medical_herb/features/common_widgets/scan_error_dialog.dart';
import 'package:medical_herb/features/screens/widgets/button_action_button_widget.dart';
import 'package:medical_herb/features/screens/widgets/confidence_threshold_widget.dart';
import 'package:medical_herb/features/screens/widgets/identified_card_widget.dart';
import 'package:medical_herb/features/screens/widgets/top_three_predections_widget.dart';
import 'package:medical_herb/features/screens/widgets/zoom_in_zoom_out_widget.dart';
import 'package:medical_herb/features/screens/widgets/confidence_score_card_widget.dart';
import 'herb_full_details_screen.dart';

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
      ScanErrorDialog.show(
        context,
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Leaf analyzed successfully!'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScanErrorDialog.show(
        context,
        result['message'] as String? ?? 'Scan failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Details Screen', backArrow: true),
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

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_originalImagePath != null)
                    ZoomInZoomOutWidget(
                      imagePath: _originalImagePath!,
                      cropKey: _cropKey,
                      onScan: () => _captureAndScan(context),
                    ),

                  if (_originalImagePath != null) const SizedBox(height: 16),

                  IdentifiedCardWidget(
                    primaryName: primaryName,
                    confidence: confidence,
                  ),
                  const SizedBox(height: 8),

                  ConfidenceScoreCardWidget(
                    confidence: confidence,
                    showDetailedMetrics: false,
                  ),
                  const SizedBox(height: 8),

                  ConfidenceThresholdWidget(
                    threshold: scanProvider.confidenceThreshold,
                    onChanged: (value) =>
                        scanProvider.confidenceThreshold = value,
                    onChangeEnd: (_) => _reprocess(context),
                  ),

                  if (topPredictions.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    TopThreePredictionsWidget(
                      predictions: topPredictions,
                      threshold: scanProvider.confidenceThreshold,
                      totalCount: allPredictions.length,
                      isLoading: scanProvider.isLoading,
                    ),
                  ],

                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'View Full Details',
                    trailIcon: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HerbFullDetailsScreen(herbName: primaryName),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  ButtonActionButtonWidget(
                    key: ValueKey(primaryName),
                    primaryName: primaryName,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
