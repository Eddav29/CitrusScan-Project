import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/data/datasource/history_api.dart';

class HistoryController extends StateNotifier<HistoryState> {
  final HistoryApi _historyApi;

  HistoryController(this._historyApi) : super(HistoryState());

  Future<void> fetchUserHistory(int userId) async {
    try {
      state = state.copyWith(isLoading: true);
      final histories = await _historyApi.fetchUserHistory(userId);
      state = state.copyWith(histories: histories, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchUserHistoryDetail(int userId, int historyId) async {
    try {
      state = state.copyWith(isLoading: true);
      final historyDetail = await _historyApi.fetchUserHistoryDetail(userId, historyId);
      state = state.copyWith(historyDetail: historyDetail, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final historyControllerProvider = StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final historyApi = ref.watch(historyApiProvider);
  return HistoryController(historyApi);
});