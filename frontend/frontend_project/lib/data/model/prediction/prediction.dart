class Prediction {
  final String predictionId;
  final String diseaseId;
  final double confidence;
  final String? secondBestDisease;
  final double? secondBestDiseaseConfidence;

  Prediction({
    required this.predictionId,
    required this.diseaseId,
    required this.confidence,
    this.secondBestDisease,
    this.secondBestDiseaseConfidence,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      predictionId: json['prediction_id'],
      diseaseId: json['disease_id'],
      confidence: json['confidence'],
      secondBestDisease: json['second_best_disease'],
      secondBestDiseaseConfidence: json['second_best_disease_confidence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction_id': predictionId,
      'disease_id': diseaseId,
      'confidence': confidence,
      'second_best_disease': secondBestDisease,
      'second_best_disease_confidence': secondBestDiseaseConfidence,
    };
  }
}