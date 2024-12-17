import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/controller/history_controller.dart';
import 'package:citrus_scan/data/model/history/history.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/screen/pages/history/history_detail_screen.dart';
import 'package:intl/intl.dart';

class RecentScanWidget extends ConsumerStatefulWidget {
  final String userId;

  const RecentScanWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _RecentScanWidgetState createState() => _RecentScanWidgetState();
}

class _RecentScanWidgetState extends ConsumerState<RecentScanWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(historyControllerProvider.notifier)
          .fetchUserHistory(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyControllerProvider);

    if (historyState is HistoryLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (historyState is HistoryError) {
      print("History Error: ${historyState.message}");
      return Center(child: Text('Tidak ada riwayat scan terbaru'));
    }

    if (historyState is HistorySuccess && historyState.histories.isNotEmpty) {
      final recentHistory = historyState.histories.first;
      return _buildScanHistoryCard(context, historyItem: recentHistory);
    }

    return Center(child: Text('Tidak ada riwayat terbaru'));
  }

  Widget _buildScanHistoryCard(
    BuildContext context, {
    required History historyItem,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
              userId: widget.userId,
              predictionId: historyItem.predictionId,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF215C3C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                historyItem.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyItem.diseaseName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    historyItem.treatment,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm:ss dd MMM yyyy')
                        .format(historyItem.createdAt),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
