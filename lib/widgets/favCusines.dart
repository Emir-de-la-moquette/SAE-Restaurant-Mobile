import 'package:flutter/material.dart';
import 'package:td2/models/modCuisine.dart';

class FavoriteCuisinesWidget extends StatefulWidget {
  const FavoriteCuisinesWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteCuisinesWidget> createState() => _FavoriteCuisinesWidgetState();
}

class _FavoriteCuisinesWidgetState extends State<FavoriteCuisinesWidget> {
  List<String> allCuisines = [];
  Set<String> selectedCuisines = {};

  @override
  void initState() {
    super.initState();
    _loadCuisines();
  }

  Future<void> _loadCuisines() async {
    List<String> cuisines = await getCuisines();
    Set<String> favCuisines = await getLocalFavCuisines();
    
    setState(() {
      allCuisines = cuisines;
      selectedCuisines = favCuisines;
    });
  }

  void _toggleCuisine(String cuisine) async {
    setState(() {
      if (selectedCuisines.contains(cuisine)) {
        selectedCuisines.remove(cuisine);
        supprLocalFavCuisine(cuisine);
      } else {
        selectedCuisines.add(cuisine);
        addLocalFavCuisine(cuisine);
      }
    });
  }

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
                onTap: () => _toggleCuisine(cuisine),
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
