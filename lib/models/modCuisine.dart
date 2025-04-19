import 'package:shared_preferences/shared_preferences.dart';


Future<List<String>> getCuisines() async {
  return [
    'Italienne',
    'Chinoise',
    'Française',
    'Mexicaine',
    'Japonaise',
    'Indienne',
  ];
}


Future<Set<String>> getLocalFavCuisines() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? favs = prefs.getStringList('fav_cuisines');
  return favs != null ? favs.toSet() : <String>{};
}


Future<void> addLocalFavCuisine(String cuisine) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favs = prefs.getStringList('fav_cuisines') ?? [];
  if (!favs.contains(cuisine)) {
    favs.add(cuisine);
    await prefs.setStringList('fav_cuisines', favs);
  }
}


Future<void> supprLocalFavCuisine(String cuisine) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favs = prefs.getStringList('fav_cuisines') ?? [];
  if (favs.contains(cuisine)) {
    favs.remove(cuisine);
    await prefs.setStringList('fav_cuisines', favs);
  }
}
