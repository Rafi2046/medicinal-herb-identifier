import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/screens/widgets/confidence_threshold_widget.dart';
import 'package:medical_herb/features/screens/widgets/top_three_predections_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_action_row_widget.dart';
import '../herb_full_details_screen.dart';

class ScanBottomSheetWidget extends StatefulWidget {
  final String primaryName;
  final double confidence;
  final List<Prediction> topPredictions;
  final int totalPredictions;
  final ScanProvider scanProvider;
  final Future<void> Function(BuildContext) onReprocess;

  const ScanBottomSheetWidget({
    super.key,
    required this.primaryName,
    required this.confidence,
    required this.topPredictions,
    required this.totalPredictions,
    required this.scanProvider,
    required this.onReprocess,
  });

  @override
  State<ScanBottomSheetWidget> createState() => _ScanBottomSheetWidgetState();
}

class _ScanBottomSheetWidgetState extends State<ScanBottomSheetWidget> {
  bool _showAdvancedSettings = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryGreen = Color(0xFF13C366);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app,
                  size: 16,
                  color: isDark ? Colors.white54 : Colors.grey[500],
                ),
                const SizedBox(width: 8),
                Text(
                  'Pinch image to zoom and drag to focus',
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IDENTIFIED AS',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white54
                                    : Colors.grey[500],
                                fontSize: 12,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.primaryName,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1A3B28),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: primaryGreen.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '${widget.confidence.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: primaryGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Confidence Score',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1A3B28),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearPercentIndicator(
                    lineHeight: 12.0,
                    percent: (widget.confidence / 100).clamp(0.0, 1.0),
                    backgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFF1F5F9),
                    progressColor: primaryGreen,
                    barRadius: const Radius.circular(12),
                    padding: EdgeInsets.zero,
                    animation: true,
                    animationDuration: 1000,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["0%", "25%", "50%", "75%", "100%"]
                        .map(
                          (text) => Text(
                            text,
                            style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 32),

                  QuickActionRowWidget(primaryName: widget.primaryName),
                  const SizedBox(height: 32),

                  if (widget.topPredictions.isNotEmpty) ...[
                    Text(
                      'Alternative Matches',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF1A3B28),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TopThreePredictionsWidget(
                      predictions: widget.topPredictions,
                      threshold: widget.scanProvider.confidenceThreshold,
                      totalCount: widget.totalPredictions,
                      isLoading: widget.scanProvider.isLoading,
                    ),
                  ],

                  Center(
                    child: TextButton.icon(
                      onPressed: () => setState(
                        () => _showAdvancedSettings = !_showAdvancedSettings,
                      ),
                      icon: Icon(
                        _showAdvancedSettings ? Icons.expand_less : Icons.tune,
                        color: Colors.grey,
                        size: 18,
                      ),
                      label: Text(
                        'Advanced Settings',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  if (_showAdvancedSettings)
                    ConfidenceThresholdWidget(
                      threshold: widget.scanProvider.confidenceThreshold,
                      onChanged: (value) =>
                          widget.scanProvider.confidenceThreshold = value,
                      onChangeEnd: (_) => widget.onReprocess(context),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white10 : Colors.grey[100]!,
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HerbFullDetailsScreen(herbName: widget.primaryName),
                    ),
                  );
                },
                child: const Text(
                  'View Full Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
