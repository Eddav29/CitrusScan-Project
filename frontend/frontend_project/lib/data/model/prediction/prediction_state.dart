import 'package:citrus_scan/data/model/prediction/prediction.dart';

class PredictionState {
  final Prediction? prediction;
  final bool isLoading;
  final String? error;

  PredictionState({
    this.prediction,
    this.isLoading = false,
    this.error,
  });

  PredictionState copyWith({
    Prediction? prediction,
    bool? isLoading,
    String? error,
  }) {
    return PredictionState(
      prediction: prediction ?? this.prediction,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}