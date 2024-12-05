import 'package:citrus_scan/data/datasource/disease_api.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiseaseDataController extends StateNotifier<DiseaseDataState> {
  final DiseaseApi _diseaseApi;

  DiseaseDataController(this._diseaseApi) : super(const DiseaseDataInitial());

  Future<void> fetchDiseases() async {
    try {
      state = const DiseaseDataLoading();
      final diseases = await _diseaseApi.getDiseases();
      state = DiseaseDataListSuccess(diseases);
    } catch (e) {
      state = DiseaseDataError(e.toString());
    }
  }

  Future<void> fetchDiseaseDetails(String id) async {
    try {
      state = const DiseaseDataLoading();
      final diseaseDetail = await _diseaseApi.getDiseaseDetails(id);
      state = DiseaseDataDetailSuccess(DiseaseData(
        id: diseaseDetail.id,
        name: diseaseDetail.name,
        description: diseaseDetail.description,
        treatment: diseaseDetail.treatment,
      ));
    } catch (e) {
      state = DiseaseDataError(e.toString());
    }
  }
}

final diseaseDataControllerProvider = StateNotifierProvider<DiseaseDataController, DiseaseDataState>((ref) {
  final diseaseDataApi = ref.watch(diseaseDataApiProvider);
  return DiseaseDataController(diseaseDataApi);
});