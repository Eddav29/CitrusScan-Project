import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/data/datasource/prediction_api.dart';

class PredictionController extends StateNotifier<PredictionState> {
  final PredictionApi _predictionApi;

  PredictionController(this._predictionApi) : super(PredictionState());

  Future<void> predict(String imagePath) async {
    try {
      state = state.copyWith(isLoading: true);
      final prediction = await _predictionApi.predict(image: imagePath);
      state = state.copyWith(prediction: prediction, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final predictionControllerProvider = StateNotifierProvider<PredictionController, PredictionState>((ref) {
  final predictionApi = ref.watch(predictionApiProvider);
  return PredictionController(predictionApi);
});