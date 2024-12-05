class Disease {
  final String diseaseId;
  final String name;
  final String description;
  final String treatment;
  final List<TreatmentStep> steps;

  Disease({
    required this.diseaseId,
    required this.name,
    required this.description,
    required this.treatment,
    required this.steps,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      diseaseId: json['disease_id'],
      name: json['name'],
      description: json['description'],
      treatment: json['treatment'],
      steps: (json['steps'] as List)
          .map((step) => TreatmentStep.fromJson(step))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_id': diseaseId,
      'name': name,
      'description': description,
      'treatment': treatment,
      'steps': steps.map((step) => step.toJson()).toList(),
    };
  }
}

class TreatmentStep {
  final int step;
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
