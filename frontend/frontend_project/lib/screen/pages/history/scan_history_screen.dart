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

  List<bool> selectedItems =
      []; // List untuk melacak status terpilih setiap item
  String sortBy = 'tanggal'; // Default: sort by date

  @override
  void initState() {
    super.initState();
    selectedItems = List.generate(scanHistory.length,
        (index) => false); // Inisialisasi status terpilih semua item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Deteksi',
          style: TextStyle(
            color: Colors.white,
          ),
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
                    height: 40, // Set height for consistency
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[200], // Background color for the search field
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    child: Row(
                      children: [
                        // Search icon inside the search bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        // Search input field
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari', // Search description
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black45,
                              ),
                              border:
                                  InputBorder.none, // Remove the default border
                            ),
                            onChanged: (value) {
                              // Implement search functionality here if needed
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Select All icon (left of sort)
                IconButton(
                  icon: Icon(Icons.select_all, color: Color(0xFF215C3C)),
                  onPressed: () {
                    setState(() {
                      // Toggle select all items
                      bool allSelected = selectedItems.every((item) => item);
                      for (int i = 0; i < selectedItems.length; i++) {
                        selectedItems[i] = !allSelected;
                      }
                    });
                  },
                ),
                // Sort icon (right of search)
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
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Align items
                        children: [
                          Text('Tanggal'),
                          if (sortBy == 'tanggal')
                            Icon(Icons.check,
                                size: 16), // Checkmark for 'Tanggal'
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'nama',
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Align items
                        children: [
                          Text('Nama'),
                          if (sortBy == 'nama')
                            Icon(Icons.check, size: 16), // Checkmark for 'Nama'
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // ListView of scan history
            Expanded(
              child: ListView.builder(
                itemCount: scanHistory.length,
                itemBuilder: (context, index) {
                  var historyItem = scanHistory[index];
                  return _buildScanHistoryCard(
                    context,
                    imagePath: historyItem['imagePath']!,
                    deteksi: historyItem['deteksi']!,
                    tanggal: historyItem['tanggal']!,
                    saran: historyItem['saran']!,
                    index: index,
                    isSelected: selectedItems[index], // Pass selection status
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun kartu riwayat scan
  Widget _buildScanHistoryCard(
    BuildContext context, {
    required String imagePath,
    required String deteksi,
    required String tanggal,
    required String saran,
    required int index,
    required bool isSelected, // Parameter tambahan untuk status terpilih
  }) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman hasil scan saat kartu diklik
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanResultScreen(imagePath: imagePath)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.red.withOpacity(
                  0.2) // Jika terpilih, beri warna merah transparan
              : Color(0xFF215C3C)
                  .withOpacity(0.1), // Warna hijau dengan transparansi
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16), // Margin between cards
        child: Stack(
          children: [
            Row(
              children: [
                // Gambar scan jeruk
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
                // Kolom teks dengan deteksi, tanggal, saran
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deteksi,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        saran, // saran tambahan
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Colors.black54, // Warna hitam dengan transparansi
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        tanggal,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected) // Jika item terpilih, tampilkan ikon hapus
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Tampilkan dialog konfirmasi
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

  // Menampilkan dialog konfirmasi sebelum menghapus item
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus deteksi ini?'),
          actions: <Widget>[
            // Tombol Batalkan dengan font abu-abu
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, // Warna teks tombol Batalkan
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa menghapus
              },
              child: Text('Batalkan'),
            ),
            // Tombol Hapus dengan font merah
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Warna teks tombol Hapus
              ),
              onPressed: () {
                setState(() {
                  scanHistory.removeAt(index); // Hapus item dari daftar
                  selectedItems.removeAt(index); // Hapus status terpilih
                });
                Navigator.of(context).pop(); // Menutup dialog setelah hapus
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
