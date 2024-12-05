class Prediction {
  final String predictionId;
  final String diseaseId;
  final String disease;
  final double confidence;
  final Map<String, dynamic>? secondBest;
  final String imagePath;

  Prediction({
    required this.predictionId,
    required this.diseaseId,
    required this.disease,
    required this.confidence,
    this.secondBest,
    required this.imagePath,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      predictionId: json['prediction_id'],
      diseaseId: json['disease_id'],
      disease: json['disease'],
      confidence: (json['confidence'] as num).toDouble(),
      secondBest: json['second_best'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction_id': predictionId,
      'disease_id': diseaseId,
      'disease': disease,
      'confidence': confidence,
      'second_best': secondBest,
      'image_path': imagePath,
    };
  }

  Prediction copyWith({
    String? predictionId,
    String? diseaseId,
    String? disease,
    double? confidence,
    Map<String, dynamic>? secondBest,
    String? imagePath,
  }) {
    return Prediction(
      predictionId: predictionId ?? this.predictionId,
      diseaseId: diseaseId ?? this.diseaseId,
      disease: disease ?? this.disease,
      confidence: confidence ?? this.confidence,
      secondBest: secondBest ?? this.secondBest,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}