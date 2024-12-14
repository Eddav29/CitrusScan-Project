import 'package:citrus_scan/data/datasource/disease_data_api.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiseaseDataController extends StateNotifier<DiseaseDataState> {
  final DiseaseDataApi _diseaseDataApi;

  DiseaseDataController(this._diseaseDataApi)
      : super(const DiseaseDataInitial());

  // Fetch list of diseases
  Future<void> fetchDiseases() async {
    try {
      state = const DiseaseDataLoading();
      final diseases = await _diseaseDataApi.getDiseases();
      state = DiseaseDataListSuccess(diseases);
    } catch (e) {
      state = DiseaseDataError(e.toString());
    }
  }

  // Fungsi untuk mengambil detail penyakit beserta langkah-langkah perawatannya
  Future<void> fetchDiseaseDetails(String id) async {
    try {
      state = const DiseaseDataLoading();
      final diseaseDetail = await _diseaseDataApi.getDiseaseDetails(id);

      // Memperbarui state dengan detail penyakit
      state = DiseaseDataDetailSuccess(diseaseDetail);
    } catch (e) {
      state = DiseaseDataError(e.toString());
    }
  }
}
