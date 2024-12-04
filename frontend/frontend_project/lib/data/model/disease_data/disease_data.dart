class DiseaseData {
  final int diseaseId;
  final String name;
  final String description;
  final String treatment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TreatmentStep> steps;

  DiseaseData({
    required this.diseaseId,
    required this.name,
    required this.description,
    required this.treatment,
    required this.createdAt,
    required this.updatedAt,
    required this.steps,
  });

  factory DiseaseData.fromJson(Map<String, dynamic> json) {
    var stepsFromJson = json['steps'] as List;
    List<TreatmentStep> stepsList = stepsFromJson.map((step) => TreatmentStep.fromJson(step)).toList();

    return DiseaseData(
      diseaseId: json['disease_id'],
      name: json['name'],
      description: json['description'],
      treatment: json['treatment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      steps: stepsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_id': diseaseId,
      'name': name,
      'description': description,
      'treatment': treatment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'steps': steps.map((step) => step.toJson()).toList(),
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