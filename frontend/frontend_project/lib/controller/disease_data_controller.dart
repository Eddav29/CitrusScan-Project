import 'package:citrus_scan/data/datasource/disease_data_api.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiseaseDataController extends StateNotifier<DiseaseDataState> {
  final DiseaseDataApi _diseaseDataApi;

  DiseaseDataController(this._diseaseDataApi) : super(const DiseaseDataInitial());

  Future<void> fetchDiseases() async {
    try {
      state = const DiseaseDataLoading();
      final diseases = await _diseaseDataApi.getDiseases();
      state = DiseaseDataListSuccess(diseases);
    } catch (e) {
      state = DiseaseDataError(e.toString());
    }
  }

  Future<void> fetchDiseaseDetails(String id) async {
    try {
      state = const DiseaseDataLoading();
      final diseaseDetail = await _diseaseDataApi.getDiseaseDetails(id);
      state = DiseaseDataDetailSuccess(DiseaseData(
        diseaseId: id,
        name: diseaseDetail.name,
        description: diseaseDetail.description,
        treatment: diseaseDetail.treatment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
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