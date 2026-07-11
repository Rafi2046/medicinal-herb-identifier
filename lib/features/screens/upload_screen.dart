import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medical_herb/features/screens/widgets/screen_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/screens/utils/heatmap_utils.dart';
import 'package:medical_herb/features/screens/widgets/screen_guide_bottom_sheet.dart';
import 'package:medical_herb/features/common_widgets/scan_error_dialog.dart';
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
  bool _showHeatmap = false;
  String? _heatmapImagePath;

  Future<void> _generateHeatmap(PredictionResult result) async {
    if (result.heatmapBase64 == null || _originalImagePath == null) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final outputPath =
          '${dir.path}/heatmap_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await compositeHeatmap(
        originalImage: File(_originalImagePath!),
        heatmapBase64: result.heatmapBase64!,
        outputPath: outputPath,
      );
      if (mounted) {
        setState(() => _heatmapImagePath = outputPath);
      }
    } catch (e) {
      debugPrint('Heatmap generation failed: $e');
    }
  }

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
    } else {
      ScanErrorDialog.show(
        context,
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
          final confidence = (result?.primaryConfidence ?? 0.0);
          final allPredictions = result?.top3 ?? [];
          final otherPredictions =
              allPredictions.where((p) => p.className != primaryName).toList()
                ..sort((a, b) => b.confidence.compareTo(a.confidence));
          final topPredictions = otherPredictions.take(3).toList();
          final hasHeatmap = result?.heatmapBase64 != null;

          if (hasHeatmap && _heatmapImagePath == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _generateHeatmap(result!);
            });
          }

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.48,
                child: _originalImagePath != null
                    ? ZoomInZoomOutWidget(
                        imagePath: _showHeatmap && _heatmapImagePath != null
                            ? _heatmapImagePath!
                            : _originalImagePath!,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasHeatmap && _heatmapImagePath != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _showHeatmap = !_showHeatmap),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _showHeatmap
                                  ? const Color(0xFF4ADE80)
                                  : Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.layers_outlined,
                                  color: _showHeatmap
                                      ? Colors.black87
                                      : Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _showHeatmap ? 'Hide Heatmap' : 'Heatmap',
                                  style: TextStyle(
                                    color: _showHeatmap
                                        ? Colors.black87
                                        : Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    InkWell(
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
                  ],
                ),
              ),

              Positioned(
                top: size.height * 0.46,
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

              if (scanProvider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
