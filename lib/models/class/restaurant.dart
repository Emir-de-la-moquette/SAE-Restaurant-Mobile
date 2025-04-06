import 'note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
class Restaurant{
  int osmId;
  String nomRestaurant;
  String description;
  String region;
  String departement;
  String ville;
  double latitude;
  double longitude;
  String siteWeb;
  String facebook;
  String telRestaurant;
  double nbEtoiles;
  int capacite;
  bool fumeur;
  bool drive;
  bool aEmporter;
  bool livraison;
  bool vegetarien;
  String horairesOuverture;
  List<String> cuisines;
  List<Note> notes;

 bool estFavory = false;


  Restaurant({
    required this.osmId,
    required this.nomRestaurant,
    required this.description,
    required this.region,
    required this.departement,
    required this.ville,
    required this.latitude,
    required this.longitude,
    required this.siteWeb,
    required this.facebook,
    required this.telRestaurant,
    required this.nbEtoiles,
    required this.capacite,
    required this.fumeur,
    required this.drive,
    required this.aEmporter,
    required this.livraison,
    required this.vegetarien,
    required this.horairesOuverture,
    required this.cuisines,
    required this.notes,
  });

  String localiser(){
    return "${this.ville}, ${this.departement}, ${this.region}";
  }

  int getNbCommentaire(){
    return this.notes.length;
  }



factory Restaurant.fromMap(Map<String, dynamic> map){
return Restaurant(
  osmId: map['osmid'] as int,
  nomRestaurant : map['nomrestaurant'].toString(),
  description: map['description'].toString(),
  region: map['nomregion'].toString(),
  departement: map['nomdepartement'].toString(),
  ville: map['nomcommune'].toString(),
  latitude: map['latitude'] as double,
  longitude: map['longitude'] as double,
  siteWeb: map['siteweb'].toString(),
  facebook: map['facebook'].toString(),
  telRestaurant: map['telrestaurant'].toString(),
  nbEtoiles: map['nbetoilemichelin'] as double,
  capacite: map['capacite'] as int,
  fumeur: map['fumeur'] as bool,
  drive: map['drive'] as bool,
  aEmporter: map['aemporter'] as bool,
  livraison: map['livraison'] as bool,
  vegetarien: map['vegetarien'] as bool,
  horairesOuverture: map['horairesouverture'] as String,
  cuisines: map['nomcuisine'] as List<String>,
  notes: map['notes'] as List<Note>,
);

}


Map<String, dynamic> toMap() {
return {
"osmid":osmId,
"nomrestaurant" :nomRestaurant,
"description":description,
"region":region,
"departement":departement,
"ville":ville,
"latitude":latitude,
"longitude":longitude,
"siteweb":siteWeb,
"facebook":facebook,
"telrestaurant":telRestaurant,
"nbetoilemichelin":nbEtoiles,
"capacite":capacite,
"fumeur":fumeur,
"drive":drive,
"aemporter":aEmporter,
"livraison":livraison,
"vegetarien":vegetarien,
"horairesouverture":horairesOuverture,
};
}



isFavorite() async{
    final response = await Supabase.instance.client.from("favori").select().eq('osmid',this.osmId);

    if (response != []){
      estFavory = true;
      return true;
    }
    estFavory = false ;
    return false;
  }

void toggleFavorite() async{
  estFavory = !estFavory;
  if (!estFavory && this.isFavorite()){
    await Supabase.instance.client.from("favori").delete().eq('osmid',this.osmId!);
  }

}

Future getCuisine() async{
    List<String> cuisine =[];
    final response =  await Supabase.instance.client.from("preparer").select("nomcuisine").eq('osmid',this.osmId);
    if (response != {} && response.isNotEmpty) {
      for (var ligne in response) {
        String nomCuisine = ligne['nomcuisine'];
        cuisine.add(nomCuisine);
        print('Nom de la cuisine: $nomCuisine');
      }
    }
    return cuisine;
  }

Future getNote() async{
  List<Note> notes =[];
  final response =  await Supabase.instance.client.from("noter").select().eq('osmid',this.osmId);
  if (response != {} && response.isNotEmpty) {

    //TODO a modif saund je rentre
    for (var ligne in response) {
      String nomCuisine = ligne['nomcuisine'];
      notes.add(nomCuisine);
      print('Nom de la cuisine: $nomCuisine');
    }
  }
  return notes;
}

}


