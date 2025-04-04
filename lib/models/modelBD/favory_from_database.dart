import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/favories.dart';

class FavoriesDataBase{
  final database = Supabase.instance.client.from("favori");

  //creation
  Future createFavories(Favories newFavories) async{
    await database.insert(newFavories.toMap());
  }

  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;


  }

  Future selectFavTotal() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }
  //Update
  Future UpdateFavories(Favories oldFavories,Favories newFavories) async{
    await database.update({
      "osmid":newFavories.osmId,
      "nomrestaurant" :newFavories.mail,

    }).eq('osmid',oldFavories.osmId!);
  }

  //delect
  Future DelectFavories(Favories favories) async{
    await database.delete().eq('osmid',favories.osmId!);
  }

//voir pour double clef primaire


}