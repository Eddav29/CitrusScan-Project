import 'history.dart';

class HistoryState {
  final List<History>? histories;
  final HistoryDetail? historyDetail;
  final bool isLoading;
  final String? error;

  HistoryState({
    this.histories,
    this.historyDetail,
    this.isLoading = false,
    this.error,
  });

  HistoryState copyWith({
    List<History>? histories,
    HistoryDetail? historyDetail,
    bool? isLoading,
    String? error,
  }) {
    return HistoryState(
      histories: histories ?? this.histories,
      historyDetail: historyDetail ?? this.historyDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}