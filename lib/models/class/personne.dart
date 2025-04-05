

class Personne {
  String emailpersonne;
  String nompersonne;
  String prenompersonne;
  String telpersonne;
  String motdepasse; //Todo a transformer
  int codecommune;
  int codedepartement;
  int coderegion;
  String role;
  bool handicap;


  Personne({
    required this.emailpersonne,
    required this.nompersonne,
    required this.prenompersonne,
    required this.telpersonne,
    required this.motdepasse,
    required this.codecommune,
    required this.codedepartement,
    required this.coderegion,
    required this.role,
    required this.handicap,

  });

  factory Personne.fromMap(Map<String, dynamic> map){
    return Personne(
      emailpersonne : map['emailpersonne'].toString(),
      nompersonne: map['nompersonne'].toString(),
      prenompersonne: map['prenompersonne'].toString(),
      telpersonne: map['telpersonne'].toString(),
      motdepasse: map['motdepasse'].toString(),
      codecommune: map['codecommune'] as int,
      codedepartement: map['codedepartement'] as int,
      coderegion: map['coderegion'] as int,
      role: map['role'].toString(),
      handicap: map['handicap'] as bool,

    );
  }


  Map<String, dynamic> toMap() {
    return {
      "emailpersonne":emailpersonne,
      "nompersonne":nompersonne,
      "prenompersonne":prenompersonne,
      "telpersonne":telpersonne,
      "motdepasse":motdepasse,
      "codecommune":codecommune,
      "codedepartement":codedepartement,
      "coderegion":coderegion,
      "role":role,
      "handicap":handicap,
    };
  }


}
