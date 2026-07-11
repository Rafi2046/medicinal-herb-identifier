class PredictionResult {
  final bool isKnown;
  final String primaryPrediction;
  final double primaryConfidence;
  final List<Prediction> top3;
  final String? heatmapBase64;

  PredictionResult({
    required this.isKnown,
    required this.primaryPrediction,
    required this.primaryConfidence,
    required this.top3,
    this.heatmapBase64,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      isKnown: json['is_known'] as bool,
      primaryPrediction: json['top_prediction'] as String,
      primaryConfidence: (json['confidence'] as num).toDouble(),
      top3: (json['top_3'] as List)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
      heatmapBase64: json['heatmap_base64'] as String?,
    );
  }
}

class Prediction {
  final String className;
  final double confidence;

  Prediction({required this.className, required this.confidence});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      className: json['label'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}