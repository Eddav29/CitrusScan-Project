import 'history.dart';

sealed class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
}

class HistorySuccess extends HistoryState {
  final List<History> histories;
  const HistorySuccess(this.histories);
}

class HistoryDetailSuccess extends HistoryState {
  final HistoryDetail detail;
  const HistoryDetailSuccess(this.detail);
}