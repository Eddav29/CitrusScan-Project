import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../search/disease_screen.dart';

class SearchDiseaseScreen extends StatefulWidget {
  @override
  _SearchDiseaseScreenState createState() => _SearchDiseaseScreenState();
}

class _SearchDiseaseScreenState extends State<SearchDiseaseScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];
  String? searchResultImagePath;
  String? searchResultName;

  // Daftar penyakit yang bisa dicari
  final List<Map<String, String>> diseases = [
    {
      'name': 'Citrus Canker',
      'image': 'assets/images/daunjeruk2.jpg',
    },
    {
      'name': 'Black Spot',
      'image': 'assets/images/jeruknipis1.jpg',
    },
    // Tambahkan penyakit lainnya di sini jika perlu
  ];

  // Simulasi pencarian penyakit dengan logo dan nama penyakit
  void _onSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        // Mencari penyakit yang mengandung substring sesuai dengan input pencarian
        final result = diseases.firstWhere(
          (disease) =>
              disease['name']!.toLowerCase().contains(query.toLowerCase()),
          orElse: () =>
              {'name': '', 'image': ''}, // Jika tidak ada hasil, return kosong
        );

        if (result['name']!.isNotEmpty) {
          searchResultImagePath = result['image'];
          searchResultName = result['name'];
        } else {
          searchResultImagePath = null; // Tidak ada hasil
          searchResultName = null;
        }
      });
    }
  }

  // Menghapus input pencarian
  void _clearSearchQuery() {
    _searchController.clear();
    setState(() {
      searchResultImagePath = null;
      searchResultName = null;
    });
  }

  // Menambahkan riwayat pencarian hanya saat memilih hasil pencarian
  void _addToSearchHistory(String query) {
    setState(() {
      if (!searchHistory.contains(query)) {
        searchHistory.add(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          'Cari Penyakit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bar pencarian
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearch,
                            decoration: InputDecoration(
                              hintText: 'Mulai pencarian anda',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearSearchQuery,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Menampilkan hasil pencarian dalam format box persegi panjang oval
            searchResultImagePath != null && searchResultName != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Arahkan ke halaman ScanResultScreen dengan mengirimkan data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiseaseScreen(
                                imagePath: searchResultImagePath!,
                              ),
                            ),
                          );
                          _addToSearchHistory(
                              searchResultName!); // Menambahkan riwayat
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20), // Oval shape
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.asset(
                                searchResultImagePath!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              searchResultName!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                    ],
                  )
                : searchResultImagePath == null &&
                        _searchController.text.isNotEmpty
                    ? Text(
                        'Tidak ada hasil untuk "${_searchController.text}"',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      )
                    : SizedBox.shrink(),
            SizedBox(height: 20),
            // Riwayat pencarian hanya tampil jika ada pencarian yang berhasil
            searchHistory.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Riwayat Pencarian',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Menampilkan riwayat pencarian
                      ...searchHistory.map((history) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(history),
                            trailing: IconButton(
                              icon: Icon(Icons.clear, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  searchHistory.remove(
                                      history); // Hapus riwayat individual
                                });
                              },
                            ),
                          )),
                      SizedBox(height: 10),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
