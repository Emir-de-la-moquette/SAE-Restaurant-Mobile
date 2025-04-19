class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

List<User> users = [
  User(email: "user@mail.com", password: "123"),
  User(email: "gros@encule.fr", password: "nig"),
  User(email: "quoi@feur.fr", password: "feur"),
  User(email: "pouler@pouler.fr", password: "roti"),
];

bool userExist(String email, String password) {
  for (var user in users) {
    if (user.email == email && user.password == password) {
      return true;
    }
  }
  return false;
}
