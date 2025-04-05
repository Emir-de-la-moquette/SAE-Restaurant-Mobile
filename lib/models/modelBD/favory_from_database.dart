import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/favories.dart';

class FavoriesDataBase{
  final database = Supabase.instance.client.from("favori");

  //creation
  Future createFavories(Favories newFavories) async{
    await database.insert(newFavories.toMap());
  }


  //Update
  Future UpdateFavories(Favories oldFavories,Favories newFavories) async{
    await database.update({
      "osmid":newFavories.osmId,
      "mail" :newFavories.mail,

    }).eq('osmid',oldFavories.osmId!);
  }

  //delect
  Future DelectFavories(Favories favories) async{
    await database.delete().eq('osmid',favories.osmId!).eq('mail',favories.mail!);
  }








  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;

  }

  Future ConvertSelectToFavorie(data)async {
    List<Map<String, dynamic>> dataMapList = await ConvertSelectToMap(data);
    List<Favories> listeFavories = [];

    for (var restaurant in dataMapList) {
      Favories rest = Favories.fromMap(restaurant);
      listeFavories.add(rest);
    }
    return listeFavories;

  }




  Future selectFavTotal(mail,idresto) async{
    final response = await database.select().eq("osmid", idresto).eq("mail", mail);
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }


  Future selectFavTotalS() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }

  //Todo a verifier
  Future estFavoris(mail,idresto) async{
    final response = await database.select().eq("osmid", idresto).eq("mail", mail);

    if(response != []){
      return true;
    }

    return false;
  }






}