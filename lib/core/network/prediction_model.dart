class PredictionResult {
  final bool success;
  final String primaryPrediction;
  final double primaryConfidence;
  final List<Prediction> top3;

  PredictionResult({
    required this.success,
    required this.primaryPrediction,
    required this.primaryConfidence,
    required this.top3,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      success: json['success'] as bool,
      primaryPrediction: json['primary_prediction'] as String,
      primaryConfidence: (json['primary_confidence'] as num).toDouble(),
      top3: (json['top_3'] as List)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Prediction {
  final String className;
  final double confidence;

  Prediction({required this.className, required this.confidence});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      className: json['class'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
