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
  List<bool> selectedItems = [];
  String sortBy = 'tanggal';

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
        } catch (e) {
          if (e.toString().contains('Unauthorized')) {
            // Handle unauthorized - redirect to login
            ref.read(authControllerProvider.notifier).logout();
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      } else {
        print("User not logged in");
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  void _filterSearchResults() {
    setState(() {
      // Update logic for search results
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterSearchResults);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final historyState = ref.watch(historyControllerProvider);
    print('History: $historyState');

    final user = authState.user;
    final histories =
        (historyState is HistorySuccess) ? historyState.histories : [];

    // Ensure selectedItems has the same length as histories
    if (selectedItems.length != histories.length) {
      selectedItems = List.generate(histories.length, (index) => false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Deteksi',
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
            // Search bar
            Container(
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
                        hintText: 'Cari riwayat',
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black45),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Displaying scan history
            Expanded(
              child: historyState is HistoryLoading
                  ? Center(child: CircularProgressIndicator())
                  : historyState is HistoryError
                      ? Center(child: Text('Error: ${historyState.message}'))
                      : ListView.builder(
                          itemCount: histories.length,
                          itemBuilder: (context, index) {
                            final historyItem = histories[index];
                            return _buildScanHistoryCard(
                              context,
                              historyItem: historyItem,
                              isSelected: selectedItems[index],
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
        // Navigate to scan detail screen if needed
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
              ),
            ),
            SizedBox(width: 16),
            // Use Expanded to avoid text overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyItem.diseaseName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  SizedBox(height: 4),
                  Text(
                    historyItem.imagePath,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('dd/MM/yyyy')
                        .format(historyItem.createdAt), // Format the DateTime
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (isSelected)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle delete history item
                },
              ),
          ],
        ),
      ),
    );
  }
}
