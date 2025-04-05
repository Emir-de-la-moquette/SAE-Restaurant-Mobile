import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/Cuisine.dart';

class CuisineDataBase{
  final database = Supabase.instance.client.from("cuisine");

  //creation
  Future createCuisine(Cuisine newCuisine) async{
    await database.insert(newCuisine.toMap());
  }


  //Update
  Future UpdateCuisine(Cuisine oldCuisine,Cuisine newCuisine) async{
    await database.update({
      "nomcuisine":newCuisine.nomcuisine,

    }).eq('nomcuisine',oldCuisine.nomcuisine!);
  }

  //delect
  Future DelectCuisine(Cuisine cuisine) async{
    await database.delete().eq('nomcuisine',cuisine.nomcuisine);
  }


  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;

  }

  Future ConvertSelectCuisine(data)async {
    List<Map<String, dynamic>> dataMapList = await ConvertSelectToMap(data);
    List<Cuisine> listeCuisine = [];

    for (var restaurant in dataMapList) {
      Cuisine rest = Cuisine.fromMap(restaurant);
      listeCuisine.add(rest);
    }
    return listeCuisine;

  }


  Future fetchCuisine() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }


}