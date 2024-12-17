class DiseaseData {
  final String diseaseId;
  final String name;
  final String? treatment;
  final String diseaseImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TreatmentStep> steps;

  DiseaseData({
    required this.diseaseId,
    required this.name,
    this.treatment,
    required this.diseaseImage,
    required this.createdAt,
    required this.updatedAt,
    required this.steps,
  });

  factory DiseaseData.fromJson(Map<String, dynamic> json) {
    var treatmentSteps = <TreatmentStep>[];
    if (json['steps'] != null) {
      treatmentSteps = List<TreatmentStep>.from(
          json['steps'].map((step) => TreatmentStep.fromJson(step)));
    }

    return DiseaseData(
      diseaseId: json['disease_id'] ?? '',
      name: json['name'] ?? 'Unknown Disease',
      treatment: json['treatment'],
      diseaseImage: json['disease_image'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      steps: treatmentSteps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_id': diseaseId,
      'name': name,
      'treatment': treatment,
      'disease_image': diseaseImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'steps': steps.map((step) => step.toJson()).toList(),
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
