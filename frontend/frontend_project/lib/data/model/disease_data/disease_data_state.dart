import 'package:citrus_scan/data/model/disease_data/disease_data.dart';

sealed class DiseaseDataState {
  const DiseaseDataState();
}

class DiseaseDataInitial extends DiseaseDataState {
  const DiseaseDataInitial();
}

class DiseaseDataLoading extends DiseaseDataState {
  const DiseaseDataLoading();
}

class DiseaseDataError extends DiseaseDataState {
  final String message;
  const DiseaseDataError(this.message);
}

class DiseaseDataListSuccess extends DiseaseDataState {
  final List<DiseaseData> diseases;
  const DiseaseDataListSuccess(this.diseases);
}

class DiseaseDataDetailSuccess extends DiseaseDataState {
  final DiseaseData diseaseDetail;
  const DiseaseDataDetailSuccess(this.diseaseDetail);
}