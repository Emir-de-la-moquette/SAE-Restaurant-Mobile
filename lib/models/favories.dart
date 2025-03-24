

class Favories {
  String mail;
  int osmId;

  Favories({
    required this.mail,
    required this.osmId,
  });

  factory Favories.fromMap(Map<String, dynamic> map){
    return Favories(
      osmId: map['osmid'] as int,
      mail: map['emailpersonne'] as String,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "osmid": osmId,
      "mail": mail,
    };
  }
}
