import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/data/datasource/prediction_api.dart';

class PredictionController extends StateNotifier<PredictionState> {
  final PredictionApi _predictionApi;

  PredictionController(this._predictionApi) : super(const PredictionInitial());

  Future<void> predict(String imagePath) async {
    try {
      state = const PredictionLoading();
      
      final prediction = await _predictionApi.predict(imagePath);
      state = PredictionSuccess(prediction);
    } catch (e) {
      state = PredictionError(e.toString());
    }
  }
}