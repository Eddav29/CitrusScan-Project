import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/navigation_bar.dart';
import 'tips_widget.dart';
import '../scan/recent_scan_widget.dart';
import '../../common/widgets/app_bar.dart';
import '../history/scan_history_screen.dart';
import 'search_disease.dart';
import 'package:go_router/go_router.dart';
import 'disease_data_widget.dart';
import 'package:citrus_scan/screen/pages/scan/scan_result_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/controller/auth_controller.dart';
import '../scan/recent_scan_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    // Ambil userId dari AuthState
    final userId = authState.user?.userId;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 70.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBar(backgroundColor: Colors.transparent),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bar pencarian
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchDiseaseScreen(),
                              ),
                            );
                          },
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
                                  child: Text(
                                    'Mulai pencarian Anda',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Selamat datang di CitrusScan, solusi untuk mendeteksi dan menganalisis jeruk dengan cepat dan mudah.",
                    style: TextStyle(fontSize: 16, fontFamily: 'Gilroy'),
                  ),
                  SizedBox(height: 20),
                  TipsWidget(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Riwayat Scan Terakhir",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF215C3C),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanHistoryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Kirim userId ke RecentScanWidget
                  userId != null
                      ? RecentScanWidget(userId: userId)
                      : Center(
                          child:
                              Text('Silakan login untuk melihat riwayat scan')),
                  SizedBox(height: 20),
                  DiseaseDataWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
