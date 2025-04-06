import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email;
  final String password;
  String nom = "";
  String prenom = "";
  String tel = "";

  User({required this.email, required this.password});
  User.full(
      {required this.email,
      required this.password,
      required this.nom,
      required this.prenom,
      required this.tel});
}

List<User> users = [
  User(email: "user@mail.com", password: "123"),
  User(email: "gros@encule.fr", password: "nig"),
  User(email: "quoi@feur.fr", password: "feur"),
  User(email: "pouler@pouler.fr", password: "roti"),
];

bool userValid(String email, String password) {
  for (var user in users) {
    if (user.email == email && user.password == password) {
      return true;
    }
  }
  return false;
}

bool userExist(String email) {
  for (var user in users) {
    if (user.email == email) {
      return true;
    }
  }
  return false;
}

bool inscription(
    String nom, String prenom, String tel, String mail, String mdp) {
  users.add(User.full(
      email: mail, password: mdp, nom: nom, prenom: prenom, tel: tel));
  return true;
}

void refreshPref(int jours) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int expirationDate =
      DateTime.now().add(Duration(days: jours)).millisecondsSinceEpoch;
  await prefs.setInt('expiration', expirationDate);
}
