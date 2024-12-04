import 'package:citrus_scan/data/model/disease_data/disease_data.dart';

class DiseaseDataState {
  final DiseaseData? diseaseData;
  final List<DiseaseData>? diseaseDataList;
  final bool isLoading;
  final String? error;

  DiseaseDataState({
    this.diseaseData,
    this.diseaseDataList,
    this.isLoading = false,
    this.error,
  });

  DiseaseDataState copyWith({
    DiseaseData? diseaseData,
    List<DiseaseData>? diseaseDataList,
    bool? isLoading,
    String? error,
  }) {
    return DiseaseDataState(
      diseaseData: diseaseData ?? this.diseaseData,
      diseaseDataList: diseaseDataList ?? this.diseaseDataList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}