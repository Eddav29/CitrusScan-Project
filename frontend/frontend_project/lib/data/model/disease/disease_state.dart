import 'package:citrus_scan/data/model/disease/disease.dart';

abstract class DiseaseState {}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoading extends DiseaseState {}

class DiseaseSuccess extends DiseaseState {
  final Disease disease;

  DiseaseSuccess(this.disease);
}

class DiseaseError extends DiseaseState {
  final String message;

  DiseaseError(this.message);
}
