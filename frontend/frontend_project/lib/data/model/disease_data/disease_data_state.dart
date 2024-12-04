import 'package:citrus_scan/data/model/disease_data/disease_data.dart';

class DiseaseDataState {
  final DiseaseData? diseaseData;
  final bool isLoading;
  final String? error;

  DiseaseDataState({
    this.diseaseData,
    this.isLoading = false,
    this.error,
  });

  DiseaseDataState copyWith({
    DiseaseData? diseaseData,
    bool? isLoading,
    String? error,
  }) {
    return DiseaseDataState(
      diseaseData: diseaseData ?? this.diseaseData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}