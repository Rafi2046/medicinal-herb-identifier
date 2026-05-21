import 'package:flutter/material.dart';

class FavoriteItem {
  final String name;
  final DateTime savedAt;

  FavoriteItem({required this.name, DateTime? savedAt})
      : savedAt = savedAt ?? DateTime.now();
}

class FavoritesProvider extends ChangeNotifier {
  final List<FavoriteItem> _items = [];

  List<FavoriteItem> get items => List.unmodifiable(_items);

  bool isFavorite(String name) {
    return _items.any((item) => item.name.toLowerCase() == name.toLowerCase());
  }

  void toggle(String name) {
    final index = _items.indexWhere(
      (item) => item.name.toLowerCase() == name.toLowerCase(),
    );
    if (index >= 0) {
      _items.removeAt(index);
    } else {
      _items.insert(0, FavoriteItem(name: name));
    }
    notifyListeners();
  }

  void add(String name) {
    if (!isFavorite(name)) {
      _items.insert(0, FavoriteItem(name: name));
      notifyListeners();
    }
  }

  void remove(String name) {
    _items.removeWhere((item) => item.name.toLowerCase() == name.toLowerCase());
    notifyListeners();
  }

  void removeAt(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
