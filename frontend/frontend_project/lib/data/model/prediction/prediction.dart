import 'package:citrus_scan/data/model/disease/disease.dart';

class Prediction {
  final String predictionId;
  final String diseaseId;
  final String disease;
  final double confidence;
  final Map<String, dynamic>? secondBest;
  final String imagePath;
  final List<TreatmentStep> treatment;  

  Prediction({
    required this.predictionId,
    required this.diseaseId,
    required this.disease,
    required this.confidence,
    this.secondBest,
    required this.imagePath,
    required this.treatment,  
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    var treatmentSteps = <TreatmentStep>[];
    if (json['treatment'] != null) { 
      treatmentSteps = List<TreatmentStep>.from(
          json['treatment'].map((step) => TreatmentStep.fromJson(step)));
    }

    return Prediction(
      predictionId: json['prediction_id'],
      diseaseId: json['disease_id'],
      disease: json['disease'],
      confidence: (json['confidence'] as num).toDouble(),
      secondBest: json['second_best'],
      imagePath: json['image_path'],
      treatment: treatmentSteps,
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
      'treatment': treatment.map((step) => step.toJson()).toList(), 
    };
  }

  Prediction copyWith({
    String? predictionId,
    String? diseaseId,
    String? disease,
    double? confidence,
    Map<String, dynamic>? secondBest,
    String? imagePath,
    List<TreatmentStep>? treatment, 
  }) {
    return Prediction(
      predictionId: predictionId ?? this.predictionId,
      diseaseId: diseaseId ?? this.diseaseId,
      disease: disease ?? this.disease,
      confidence: confidence ?? this.confidence,
      secondBest: secondBest ?? this.secondBest,
      imagePath: imagePath ?? this.imagePath,
      treatment: treatment ?? this.treatment, 
    );
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
