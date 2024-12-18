import 'package:citrus_scan/screen/pages/history/history_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/navigation_bar.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:citrus_scan/data/model/history/history.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:intl/intl.dart';

class ScanHistoryScreen extends ConsumerStatefulWidget {
  @override
  _ScanHistoryScreenState createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends ConsumerState<ScanHistoryScreen> {
  TextEditingController searchController = TextEditingController();
  List<History> filteredHistories = []; // Daftar history hasil filter
  String sortBy = 'tanggal'; // Default sortir by tanggal

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authControllerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (authState.user != null) {
        final userId = authState.user!.userId;
        try {
          await ref
              .read(historyControllerProvider.notifier)
              .fetchUserHistory(userId);
          _filterSearchResults(); // Inisialisasi filter dengan semua data
        } catch (e) {
          if (e.toString().contains('Unauthorized')) {
            ref.read(authControllerProvider.notifier).logout();
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    searchController.addListener(_filterSearchResults);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterSearchResults);
    searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults() {
    final historyState = ref.read(historyControllerProvider);
    if (historyState is HistorySuccess) {
      final keyword = searchController.text.toLowerCase();
      setState(() {
        filteredHistories = historyState.histories
            .where((history) =>
                history.diseaseName.toLowerCase().contains(keyword))
            .toList();
        _sortHistories(); // Terapkan sortir setelah filter
      });
    }
  }

  void _sortHistories() {
    setState(() {
      if (sortBy == 'tanggal') {
        filteredHistories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else if (sortBy == 'nama') {
        filteredHistories.sort((a, b) =>
            a.diseaseName.toLowerCase().compareTo(b.diseaseName.toLowerCase()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyControllerProvider);

    if (filteredHistories.isEmpty && historyState is HistorySuccess) {
      filteredHistories = historyState.histories;
      _sortHistories();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Scan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF215C3C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar + Sort button
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari nama penyakit',
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.black45),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              _filterSearchResults();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Sort Icon
                PopupMenuButton<String>(
                  icon: Icon(Icons.sort, color: Colors.grey),
                  onSelected: (value) {
                    setState(() {
                      sortBy = value;
                      _sortHistories();
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'tanggal',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tanggal'),
                          if (sortBy == 'tanggal')
                            Icon(Icons.check, color: Colors.grey),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'nama',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama'),
                          if (sortBy == 'nama')
                            Icon(Icons.check, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Displaying filtered scan history
            Expanded(
              child: historyState is HistoryLoading
                  ? Center(child: CircularProgressIndicator())
                  : historyState is HistoryError
                      ? Center(child: Text('Tidak ada riwayat scan'))
                      : filteredHistories.isEmpty
                          ? Center(child: Text('Tidak ada data ditemukan'))
                          : ListView.builder(
                              itemCount: filteredHistories.length,
                              itemBuilder: (context, index) {
                                final historyItem = filteredHistories[index];
                                return _buildScanHistoryCard(
                                  context,
                                  historyItem: historyItem,
                                  isSelected: false,
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanHistoryCard(
    BuildContext context, {
    required History historyItem,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        final userId = ref.read(authControllerProvider).user!.userId;
        final predictionId = historyItem.predictionId;
        if (predictionId != 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailHistoryScreen(
                userId: userId,
                predictionId: predictionId.toString(),
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF215C3C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                historyItem.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 80, color: Colors.grey);
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyItem.diseaseName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    historyItem.treatment,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm:ss dd MMM yyyy')
                        .format(historyItem.createdAt),
                    style: TextStyle(fontSize: 14, color: Colors.black54),
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
