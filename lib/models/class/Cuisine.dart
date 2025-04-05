

class Cuisine {
  String nomcuisine;


  Cuisine({
    required this.nomcuisine,
  });

  factory Cuisine.fromMap(Map<String, dynamic> map){
    return Cuisine(
      nomcuisine: map['nomcuisine'] as String,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "nomcuisine": nomcuisine,
    };
  }


}
