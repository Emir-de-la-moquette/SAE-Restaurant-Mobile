import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:td2/models/class/personne.dart';
import '../class/restaurant.dart';

class PersonneDataBase{
  final database = Supabase.instance.client.from("personne");

  //creation
  Future createPersonne(Personne newPersonne) async{
    await database.insert(newPersonne.toMap());
  }

/*                 Doute

  function insertClient_light($nom, $prenom, $tel, $email, $mdp, $handicap) {
    global $connexion;
    $hash=hash('sha256',$mdp);
    $requete = $connexion->prepare("INSERT INTO PERSONNE (EMailPersonne, PrenomPersonne, NomPersonne, TelPersonne, MotDePasse, Role, Handicap) Values (?,?,?,?,?,?,?)");
    $requete->execute([$email, $prenom, $nom, $tel, $hash, "Client", $handicap]);
  }
*/

  //Update
  Future UpdateRestaurant(Personne oldPersonne,Personne newPersonne) async{
    await database.update({

      "emailpersonne": newPersonne.emailpersonne,
      "nompersonne": newPersonne.nompersonne,
      "prenompersonne": newPersonne.prenompersonne,
      "telpersonne": newPersonne.telpersonne,
      "motdepasse": newPersonne.motdepasse,
      "codecommune": newPersonne.codecommune,
      "codedepartement": newPersonne.codedepartement,
      "coderegion": newPersonne.coderegion,
      "role": newPersonne.role,
      "handicap": newPersonne.handicap,

    }).eq('emailpersonne',newPersonne.emailpersonne!);
  }

  //delect
  Future DelectRestaurant(Personne personne) async{
    await database.delete().eq('emailpersonne',personne.emailpersonne!);
  }


  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;

  }

  Future ConvertSelectToPersonne(data)async {
    List<Map<String, dynamic>> dataMapList = await ConvertSelectToMap(data);
    List<Personne> listePersonne = [];
    for (var personne in dataMapList) {
      Personne rest = Personne.fromMap(personne);
      listePersonne.add(rest);
    }
    return listePersonne;
  }



  Future utilisateurExistant(mail, mdp) async{
    //todo trouver se"curiter
    final response = await database.select().eq("emailpersonne", mail).eq("motdepasse", mdp);

    if(response != []){
      return true;
    }

    return false;
  }


  Future getUtilisateur(mail) async {
    final response = await database.select().eq("emailpersonne", mail);
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }











}


