class History {
  final int predictionId;
  final String diseaseName;
  final DateTime createdAt;
  final String imagePath;

  History({
    required this.predictionId,
    required this.diseaseName,
    required this.createdAt,
    required this.imagePath,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      predictionId: json['prediction_id'],
      diseaseName: json['disease_name'],
      createdAt: DateTime.parse(json['created_at']),
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction_id': predictionId,
      'disease_name': diseaseName,
      'created_at': createdAt.toIso8601String(),
      'image_path': imagePath,
    };
  }
}

class HistoryDetail {
  final String diseaseName;
  final double? confidence;
  final String imagePath;
  final String description;
  final String treatment;
  final List<TreatmentStep> steps;
  final String createdAt;

  HistoryDetail({
    required this.diseaseName,
    required this.confidence,
    required this.imagePath,
    required this.description,
    required this.treatment,
    required this.steps,
    required this.createdAt,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    var stepsFromJson = json['steps'] as List;
    List<TreatmentStep> stepsList = stepsFromJson.map((step) => TreatmentStep.fromJson(step)).toList();

    return HistoryDetail(
      diseaseName: json['disease_name'],
      confidence: json['confidence'],
      imagePath: json['image_path'],
      description: json['description'],
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
      'description': description,
      'treatment': treatment,
      'steps': steps.map((step) => step.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class TreatmentStep {
  final String step;
  final String action;

  TreatmentStep({
    required this.step,
    required this.action,
  });

  factory TreatmentStep.fromJson(Map<String, dynamic> json) {
    return TreatmentStep(
      step: json['step'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'action': action,
    };
  }
}