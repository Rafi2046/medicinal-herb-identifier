import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';

class HistoryItem {
  final String id;
  final String herbName;
  final String dotImage;
  final String herbImage;
  final String iconImage;
  final String time;
  final String confidence;
  final String category;

  HistoryItem({
    required this.id,
    required this.herbName,
    required this.dotImage,
    required this.herbImage,
    required this.iconImage,
    required this.time,
    required this.confidence,
    required this.category,
  });
}

class HistoryProvider extends ChangeNotifier {
  final List<HistoryItem> _items = [
    HistoryItem(
      id: '1',
      herbName: 'Mint',
      dotImage: AppImages.greenDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.upload,
      time: '10:32 AM',
      confidence: '94%',
      category: 'TODAY',
    ),
    HistoryItem(
      id: '2',
      herbName: 'Mint',
      dotImage: AppImages.yellowDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.upload,
      time: '11:00 AM',
      confidence: '85%',
      category: 'TODAY',
    ),
    HistoryItem(
      id: '3',
      herbName: 'Mint',
      dotImage: AppImages.greenDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.camara,
      time: '09:15 AM',
      confidence: '92%',
      category: 'YESTERDAY',
    ),
    HistoryItem(
      id: '4',
      herbName: 'Mint',
      dotImage: AppImages.yellowDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.camara,
      time: '02:30 PM',
      confidence: '78%',
      category: 'YESTERDAY',
    ),
    HistoryItem(
      id: '5',
      herbName: 'Mint',
      dotImage: AppImages.greenDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.upload,
      time: '04:00 PM',
      confidence: '96%',
      category: 'THIS WEEK',
    ),
    HistoryItem(
      id: '6',
      herbName: 'Mint',
      dotImage: AppImages.yellowDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.camara,
      time: '11:45 AM',
      confidence: '88%',
      category: 'THIS WEEK',
    ),
    HistoryItem(
      id: '7',
      herbName: 'Mint',
      dotImage: AppImages.yellowDot,
      herbImage: 'assets/background_image/joba.webp',
      iconImage: AppImages.upload,
      time: '03:20 PM',
      confidence: '72%',
      category: 'THIS WEEK',
    ),
  ];

  List<HistoryItem> get items => _items;

  List<HistoryItem> getItemsByCategory(String category) {
    return _items.where((item) => item.category == category).toList();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}