import 'package:citrus_scan/data/model/prediction/prediction.dart';

sealed class PredictionState {
  const PredictionState();
}

class PredictionInitial extends PredictionState {
  const PredictionInitial();
}

class PredictionLoading extends PredictionState {
  const PredictionLoading();
}

class PredictionSuccess extends PredictionState {
  final Prediction prediction;
  const PredictionSuccess(this.prediction);
}

class PredictionError extends PredictionState {
  final String message;
  const PredictionError(this.message);
}