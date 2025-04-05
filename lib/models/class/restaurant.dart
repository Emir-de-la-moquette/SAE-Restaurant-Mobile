import 'note.dart';

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
  nbEtoiles: map['nbetoilemichelin'] as double, //TODO voir si etoile michelin ou ensemble de note
  capacite: map['capacite'] as int,
  fumeur: map['fumeur'] as bool,
  drive: map['drive'] as bool,
  aEmporter: map['aemporter'] as bool,
  livraison: map['livraison'] as bool,
  vegetarien: map['vegetarien'] as bool,
  horairesOuverture: map['horairesouverture'] as String,
  cuisines: map['nomcuisine'] as List<String>,// todo voir si modif
  notes: map['notes'] as List<Note>,// todo voir si modif
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
"cuisines":cuisines,
"notes":notes,

};
}

}


