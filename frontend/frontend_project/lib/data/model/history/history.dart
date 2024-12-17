class History {
  final String predictionId;
  final String diseaseName;
  final String treatment;
  final DateTime createdAt;
  final String imagePath;

  History({
    required this.predictionId,
    required this.diseaseName,
    required this.treatment,
    required this.createdAt,
    required this.imagePath,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    var predictionId = json['prediction_id'];

    if (predictionId == null || predictionId is! String) {
      print('Invalid prediction_id: $predictionId');
      predictionId = '';
    }

    return History(
      predictionId: predictionId,
      diseaseName: json['disease_name'] ?? 'Unknown Disease',
      treatment: json['treatment'] ?? 'No Treatment',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      imagePath: json['image_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction_id': predictionId,
      'disease_name': diseaseName,
      'treatment': treatment,
      'created_at': createdAt.toIso8601String(),
      'image_path': imagePath,
    };
  }
}

class HistoryDetail {
  final String diseaseName;
  final double confidence;
  final String imagePath;
  final String treatment;
  final List<TreatmentStep> steps;
  final String createdAt;

  HistoryDetail({
    required this.diseaseName,
    required this.confidence,
    required this.imagePath,
    required this.treatment,
    required this.steps,
    required this.createdAt,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    var stepsFromJson = json['steps'] as List;
    List<TreatmentStep> stepsList =
        stepsFromJson.map((step) => TreatmentStep.fromJson(step)).toList();

    return HistoryDetail(
      diseaseName: json['disease_name'],
      confidence: json['confidence'],
      imagePath: json['image_path'],
      treatment: json['treatment'],
      steps: stepsList,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_name': diseaseName,
      'confidence': confidence,
      'image_path': imagePath,
      'treatment': treatment,
      'steps': steps.map((step) => step.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class TreatmentStep {
  final String description;
  final String symptoms;
  final String solutions;
  final String prevention;

  TreatmentStep({
    required this.description,
    required this.symptoms,
    required this.solutions,
    required this.prevention,
  });

  factory TreatmentStep.fromJson(Map<String, dynamic> json) {
    return TreatmentStep(
      description: json['description'] ?? '',
      symptoms: json['symptoms'] ?? '',
      solutions: json['solutions'] ?? '',
      prevention: json['prevention'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'symptoms': symptoms,
      'solutions': solutions,
      'prevention': prevention,
    };
  }
}
