import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/restaurant.dart';

class RestaurantDataBase{
  final database = Supabase.instance.client.from("restaurant");

  //creation
  Future createRestaurant(Restaurant newRestaurant) async{
    await database.insert(newRestaurant.toMap());
  }

  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;
    // Afficher la nouvelle liste

  }

  Future selectRestaurantTotal() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }

  //Update
  Future UpdateRestaurant(Restaurant oldRestaurant,Restaurant newRestaurant) async{
    await database.update({
      "osmid":newRestaurant.osmId,
      "nomrestaurant" :newRestaurant.nomRestaurant,
      "description":newRestaurant.description,
      "region":newRestaurant.region,
      "departement":newRestaurant.departement,
      "ville":newRestaurant.ville,
      "latitude":newRestaurant.latitude,
      "longitude":newRestaurant.longitude,
      "siteweb":newRestaurant.siteWeb,
      "facebook":newRestaurant.facebook,
      "telrestaurant":newRestaurant.telRestaurant,
      "nbetoilemichelin":newRestaurant.nbEtoiles,
      "capacite":newRestaurant.capacite,
      "fumeur":newRestaurant.fumeur,
      "drive":newRestaurant.drive,
      "aemporter":newRestaurant.aEmporter,
      "livraison":newRestaurant.livraison,
      "vegetarien":newRestaurant.vegetarien,
      "horairesouverture":newRestaurant.horairesOuverture,
      "cuisines":newRestaurant.cuisines,
      "notes":newRestaurant.notes,

    }).eq('osmid',oldRestaurant.osmId!);
  }

  //delect
  Future DelectRestaurant(Restaurant restaurant) async{
    await database.delete().eq('osmid',restaurant.osmId!);
  }

}


class FavoriesDataBase{
  final database = Supabase.instance.client.from("favori");

  //creation
  Future createFavories(Favories newFavories) async{
    await database.insert(newFavories.toMap());
  }

  //read
  final stream =Supabase.instance.client.from("favori").stream(primaryKey: ['osmid','emailpersonne'],
  ).map((data) => data.map((noteMap) => Favories.fromMap(noteMap))).toList();

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