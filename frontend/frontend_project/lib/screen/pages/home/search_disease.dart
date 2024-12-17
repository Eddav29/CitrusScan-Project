import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/controller/disease_data_controller.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/screen/pages/home/disease_treatment_screen.dart';

class SearchDiseaseScreen extends ConsumerStatefulWidget {
  @override
  _SearchDiseaseScreenState createState() => _SearchDiseaseScreenState();
}

class _SearchDiseaseScreenState extends ConsumerState<SearchDiseaseScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];
  String searchQuery = '';

  // Add search to update the state
  void _onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  // Add a search history record
  void _addToSearchHistory(String query) {
    setState(() {
      if (!searchHistory.contains(query)) {
        searchHistory.add(query);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch diseases when the widget is first loaded
      ref.read(diseaseDataControllerProvider.notifier).fetchDiseases();
    });
  }

  @override
  Widget build(BuildContext context) {
    final diseaseState = ref.watch(diseaseDataControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
            // Search bar
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
                              hintText: 'Masukkan nama penyakit',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _onSearch('');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Disease Data State Handling
            Expanded(
              child: () {
                if (diseaseState is DiseaseDataLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (diseaseState is DiseaseDataError) {
                  return Center(
                    child: Text(
                      'Error: ${(diseaseState as DiseaseDataError).message}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (diseaseState is DiseaseDataListSuccess) {
                  final diseases =
                      (diseaseState as DiseaseDataListSuccess).diseases;

                  // Filter diseases based on search query
                  final filteredDiseases = diseases
                      .where((disease) =>
                          disease.name.toLowerCase().contains(searchQuery) &&
                          disease.name.toLowerCase() != "healthy" &&
                          disease.name.toLowerCase() != "not citrus leaf")
                      .toList();

                  if (filteredDiseases.isEmpty) {
                    return Center(
                      child: Text(
                        searchQuery.isEmpty
                            ? 'Masukkan kata kunci untuk mencari penyakit.'
                            : 'Tidak ada hasil untuk "$searchQuery".',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDiseases.length,
                    itemBuilder: (context, index) {
                      final disease = filteredDiseases[index];
                      final imageUrl =
                          "http://10.0.2.2:8000/storage/${disease.diseaseImage}";

                      return GestureDetector(
                        onTap: () {
                          _addToSearchHistory(disease.name);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiseaseTreatmentScreen(
                                diseaseId: disease.diseaseId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                              child: Image.network(
                                imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, _) => Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                            ),
                            title: Text(
                              disease.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Tidak ada data penyakit.'));
                }
              }(),
            ),

            // Search History
            if (searchHistory.isNotEmpty)
              Column(
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
                  ...searchHistory.map((history) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(history),
                        trailing: IconButton(
                          icon: Icon(Icons.clear, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              searchHistory.remove(history);
                            });
                          },
                        ),
                      )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
