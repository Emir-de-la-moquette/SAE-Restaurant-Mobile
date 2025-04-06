import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/restaurant.dart';

class RestaurantDataBase{
  final database = Supabase.instance.client.from("restaurant");


  //creation
  Future createRestaurant(Restaurant newRestaurant) async{
    await database.insert(newRestaurant.toMap());
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






  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;

  }

  Future<List<Restaurant>> ConvertSelectToRestaurant(data)async {
    List<Map<String, dynamic>> dataMapList = await ConvertSelectToMap(data);
    List<Restaurant> listeResto = [];

    for (var restaurant in dataMapList) {
      Restaurant rest = Restaurant.fromMap(restaurant);
      rest.getCuisine();
      rest.getNote();

      listeResto.add(rest);
    }
    return listeResto;

  }


  Future<List<Restaurant>> selectRestaurantTotal() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Restaurant> dataMap = await ConvertSelectToRestaurant(data);
    print(dataMap[0].cuisines);
    return dataMap;
  }









}


