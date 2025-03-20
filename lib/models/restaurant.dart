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
}