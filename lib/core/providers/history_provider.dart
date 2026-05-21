import 'package:flutter/material.dart';

enum ScanSource { camera, gallery }

class HistoryItem {
  final String id;
  final String herbName;
  final double confidence;
  final DateTime scannedAt;
  final ScanSource source;

  HistoryItem({
    required this.id,
    required this.herbName,
    required this.confidence,
    required this.scannedAt,
    required this.source,
  });

  String get category {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final scanDate = DateTime(scannedAt.year, scannedAt.month, scannedAt.day);

    if (scanDate == today) return 'TODAY';
    if (scanDate == yesterday) return 'YESTERDAY';
    if (scanDate.isAfter(today.subtract(const Duration(days: 7)))) return 'THIS WEEK';
    return 'OLDER';
  }

  String get time {
    final hour = scannedAt.hour > 12 ? scannedAt.hour - 12 : scannedAt.hour;
    final period = scannedAt.hour >= 12 ? 'PM' : 'AM';
    final minute = scannedAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}

class HistoryProvider extends ChangeNotifier {
  final List<HistoryItem> _items = [];

  List<HistoryItem> get items => List.unmodifiable(_items);

  void addScan(String herbName, double confidence, ScanSource source) {
    _items.insert(0, HistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      herbName: herbName,
      confidence: confidence,
      scannedAt: DateTime.now(),
      source: source,
    ));
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  List<HistoryItem> getItemsByCategory(String category) {
    return _items.where((item) => item.category == category).toList();
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}
