class ScanResult {
  final String imagePath;
  final String plantName;
  final String condition;
  bool isBookmarked;

  ScanResult({
    required this.imagePath,
    required this.plantName,
    required this.condition,
    this.isBookmarked = false, // Secara default tidak di-bookmark
  });
}
