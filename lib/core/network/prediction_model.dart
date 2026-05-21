class PredictionResult {
  final String status;
  final String primaryPrediction;
  final double primaryConfidence;
  final List<Prediction> allPredictions;

  PredictionResult({
    required this.status,
    required this.primaryPrediction,
    required this.primaryConfidence,
    required this.allPredictions,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      status: json['status'] as String,
      primaryPrediction: json['primary_prediction'] as String,
      primaryConfidence: (json['primary_confidence'] as num).toDouble(),
      allPredictions: (json['all_predictions'] as List)
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
      className: json['class_name'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
