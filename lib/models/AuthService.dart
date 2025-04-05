import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? expirationDate = prefs.getInt('expiration');

    if (expirationDate == null) return false;

    // Vérifie si la date d'expiration est dépassée
    int now = DateTime.now().millisecondsSinceEpoch;
    return now < expirationDate;
  }
}
