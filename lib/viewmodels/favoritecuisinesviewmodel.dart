import 'package:flutter/material.dart';

class FavoriteCuisinesViewModel extends ChangeNotifier {
  final List<String> allCuisines = [
    'Italienne',
    'Chinoise',
    'Française',
    'Mexicaine',
    'Japonaise',
    'Indienne',
    'chier',
  ];

  final Set<String> _selectedCuisines = {};

  Set<String> get selectedCuisines => _selectedCuisines;

  void toggleCuisine(String cuisine) {
    if (_selectedCuisines.contains(cuisine)) {
      _selectedCuisines.remove(cuisine);
    } else {
      _selectedCuisines.add(cuisine);
    }
    notifyListeners();
  }
}
