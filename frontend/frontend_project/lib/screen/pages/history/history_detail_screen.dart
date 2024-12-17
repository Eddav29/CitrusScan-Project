import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/provider/provider.dart';

class DetailHistoryScreen extends ConsumerStatefulWidget {
  final String userId;
  final String predictionId;

  const DetailHistoryScreen(
      {Key? key, required this.userId, required this.predictionId})
      : super(key: key);

  @override
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends ConsumerState<DetailHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(historyControllerProvider.notifier)
          .fetchHistoryDetail(widget.userId, widget.predictionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final historyState = ref.watch(historyControllerProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 245, 239, 1),
      body: Stack(
        children: [
          // Display image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image for history
              if (historyState is HistoryDetailSuccess)
                Image.file(
                  File(historyState.detail.imagePath),
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            ],
          ),

          // Positioned Back Arrow Icon
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.5),
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),

          // Rest of the UI content
          Positioned(
            top: screenHeight * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(234, 245, 239, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: _buildContent(historyState),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(HistoryState state) {
    if (state is HistoryInitial) {
      // Initial state when history data is not loaded yet
      return const Center(
        child: Text('Welcome, please load your history'),
      );
    } else if (state is HistoryLoading) {
      // Loading state while fetching data
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading your history...'),
          ],
        ),
      );
    } else if (state is HistoryError) {
      // Error state when fetching data fails
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text(state.message),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Retry fetching user history
                ref
                    .read(historyControllerProvider.notifier)
                    .fetchUserHistory("userId"); // Replace with actual user ID
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state is HistorySuccess) {
      // Success state, displaying the list of history items
      var histories = state.histories;
      return ListView.builder(
        itemCount: histories.length,
        itemBuilder: (context, index) {
          var history = histories[index];
          return ListTile(
            title: Text(history.diseaseName),
            subtitle: Text(history.createdAt.toString()),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                // Navigate to history detail screen
                ref.read(historyControllerProvider.notifier).fetchHistoryDetail(
                    "userId", history.predictionId.toString());
              },
            ),
          );
        },
      );
    } else if (state is HistoryDetailSuccess) {
      // Success state, displaying detailed history information
      var detail = state.detail;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Disease: ${detail.diseaseName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Confidence: ${detail.confidence ?? 'N/A'}'),
          SizedBox(height: 8),
          Text('Treatment: ${detail.treatment}'),
          SizedBox(height: 16),
          for (var step in detail.steps) ...[
            Text('Description: ${step.description}'),
            Text('Symptoms: ${step.symptoms}'),
            Text('Solutions: ${step.solutions}'),
            Text('Prevention: ${step.prevention}'),
            SizedBox(height: 8),
          ],
        ],
      );
    }

    return const Center(child: Text('State not recognized'));
  }

  Widget buildInfoBox(
      {required String title,
      required String content,
      required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
