import 'package:citrus_scan/data/datasource/history_api.dart';
import 'package:citrus_scan/data/model/history/history.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider =
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final historyApi = ref.watch(historyApiProvider);
  return HistoryController(historyApi);
});

class HistoryController extends StateNotifier<HistoryState> {
  final HistoryApi _historyApi;

  HistoryController(this._historyApi) : super(const HistoryInitial());

  Future<void> fetchUserHistory(String userId) async {
    try {
      state = const HistoryLoading();
      final histories = await _historyApi.fetchUserHistory(userId);
      state = HistorySuccess(histories);
    } catch (e) {
      state = HistoryError(e.toString());
    }
  }

  Future<void> fetchHistoryDetail(String userId, String predictionId) async {
    try {
      state = const HistoryLoading();
      final detail =
          await _historyApi.fetchUserHistoryDetail(userId, predictionId);
      state = HistoryDetailSuccess(detail);
    } catch (e) {
      state = HistoryError(e.toString());
    }
  }
}
