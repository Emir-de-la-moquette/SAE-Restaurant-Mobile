import 'package:flutter/material.dart';

class FavoriteCuisinesWidget extends StatefulWidget {
  const FavoriteCuisinesWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteCuisinesWidget> createState() => _FavoriteCuisinesWidgetState();
}

class _FavoriteCuisinesWidgetState extends State<FavoriteCuisinesWidget> {
  final List<String> allCuisines = [
    'Italienne',
    'Chinoise',
    'Française',
    'Mexicaine',
    'Japonaise',
    'Indienne',
    'Italienne',
    'Chinoise',
    'Française',
    'Mexicaine',
    'Japonaise',
    'Indienne',
    'Italienne',
    'Chinoise',
    'Française',
    'Mexicaine',
    'Japonaise',
    'Indienne',
  ];

  final Set<String> selectedCuisines = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cuisines favorites",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allCuisines.map((cuisine) {
              bool isSelected = selectedCuisines.contains(cuisine);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedCuisines.remove(cuisine);
                    } else {
                      selectedCuisines.add(cuisine);
                    }
                  });
                },
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.white,
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      cuisine,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
