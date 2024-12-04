import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/data/datasource/disease_data_api.dart';

class DiseaseDataController extends StateNotifier<DiseaseDataState> {
  final DiseaseDataApi _diseaseDataApi;

  DiseaseDataController(this._diseaseDataApi) : super(DiseaseDataState());

  Future<void> fetchDiseases() async {
    try {
      state = state.copyWith(isLoading: true);
      final diseaseDataList = await _diseaseDataApi.getDiseases();
      state = state.copyWith(diseaseDataList: diseaseDataList, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchDiseaseDetails(int id) async {
    try {
      state = state.copyWith(isLoading: true);
      final diseaseData = await _diseaseDataApi.getDiseaseDetails(id);
      state = state.copyWith(diseaseData: diseaseData, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final diseaseDataControllerProvider = StateNotifierProvider<DiseaseDataController, DiseaseDataState>((ref) {
  final diseaseDataApi = ref.watch(diseaseDataApiProvider);
  return DiseaseDataController(diseaseDataApi);
});