import 'package:flutter/material.dart';
import '../scan/scan_result_screen.dart';

class ScanHistoryScreen extends StatefulWidget {
  @override
  _ScanHistoryScreenState createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  List<Map<String, String>> scanHistory = [
    {
      'deteksi': 'Black Spot',
      'saran':
          'Pangkas daun yang terinfeksi dan aplikasikan fungisida secara rutin.',
      'tanggal': '2 Okt 2024',
      'imagePath': 'assets/images/jeruknipis.jpeg',
    },
    {
      'deteksi': 'Jeruk Manis',
      'saran': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'tanggal': '2 Okt 2024',
      'imagePath': 'assets/images/jeruk1.png',
    },
  ];

  List<Map<String, String>> filteredHistory = [];
  TextEditingController searchController = TextEditingController();

  List<bool> selectedItems = [];
  String sortBy = 'tanggal';

  @override
  void initState() {
    super.initState();
    filteredHistory = List.from(scanHistory);
    selectedItems = List.generate(scanHistory.length, (index) => false);
    searchController.addListener(_filterSearchResults);
  }

  // Fungsi untuk melakukan pencarian
  void _filterSearchResults() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredHistory = scanHistory
          .where((item) =>
              item['deteksi']!.toLowerCase().contains(query) ||
              item['saran']!.toLowerCase().contains(query))
          .toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Deteksi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF215C3C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row containing the select all, search, and sort buttons
            Row(
              children: [
                // Search bar with icon and text inside one border
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
                              hintText: 'Cari',
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.black45),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Icon to clear search
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              filteredHistory = List.from(
                                  scanHistory); // Reset to original list
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.select_all, color: Color(0xFF215C3C)),
                  onPressed: () {
                    setState(() {
                      bool allSelected = selectedItems.every((item) => item);
                      for (int i = 0; i < selectedItems.length; i++) {
                        selectedItems[i] = !allSelected;
                      }
                    });
                  },
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.sort, color: Color(0xFF215C3C)),
                  onSelected: (value) {
                    setState(() {
                      sortBy = value;
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'tanggal',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tanggal'),
                          if (sortBy == 'tanggal') Icon(Icons.check, size: 16),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'nama',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama'),
                          if (sortBy == 'nama') Icon(Icons.check, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHistory.length,
                itemBuilder: (context, index) {
                  var historyItem = filteredHistory[index];
                  return _buildScanHistoryCard(
                    context,
                    imagePath: historyItem['imagePath']!,
                    deteksi: historyItem['deteksi']!,
                    tanggal: historyItem['tanggal']!,
                    saran: historyItem['saran']!,
                    index: index,
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
    required String imagePath,
    required String deteksi,
    required String tanggal,
    required String saran,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanResultScreen(imagePath: imagePath)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF215C3C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deteksi,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        saran,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        tanggal,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, index);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus deteksi ini?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batalkan'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  scanHistory.removeAt(index);
                  selectedItems.removeAt(index);
                  filteredHistory =
                      List.from(scanHistory); // Reset filtered list
                });
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
