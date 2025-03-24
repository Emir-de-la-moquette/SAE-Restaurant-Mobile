import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_food/UI/rating.dart';
import 'package:my_little_food/models/note.dart';
import 'package:my_little_food/models/restaurant.dart';
import 'package:provider/provider.dart';

import 'commentaireUI.dart';

class RestaurantUI extends StatelessWidget {
  bool isFavorite = true;
  late Restaurant resto = Restaurant(
      osmId: 1,
      nomRestaurant: "nomRestaurant",
      description: "description",
      region: "region",
      departement: "departement",
      ville: "ville",
      latitude: 1,
      longitude: 1,
      siteWeb: "siteWeb",
      facebook: "facebook",
      telRestaurant: "telRestaurant",
      nbEtoiles: 3,
      capacite: 12,
      fumeur: false,
      drive: false,
      aEmporter: true,
      livraison: true,
      vegetarien: true,
      horairesOuverture: "horairesOuverture",
      cuisines: [
        "cuisines",
        "bouffe"
      ],
      notes: [
        Note(
            mail: "mail",
            note: 2,
            commentaire: "commentaire",
            date: "2025-03-22",
            nomAuteur: "nomAuteur",
            prenomAuteur: "prenomAuteur"),
        Note(
            mail: "mail2",
            note: 2,
            commentaire: "commentaire2",
            date: "1234-12-12",
            nomAuteur: "nomAuteur2",
            prenomAuteur: "prenomAuteur2")
      ]);

  //const RestaurantUI({super.key, required this.osmID});
  RestaurantUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              RatingScreen(),
              IconButton(
                  icon: Icon(
                    isFavorite // à remplacer avec la valeur de la BD
                        ? Icons.favorite
                        : Icons.favorite_border, // Cœur plein ou vide
                    color: isFavorite
                        ? Colors.red
                        : Colors.grey, // Couleur rouge pour favori, gris sinon
                    size: 50.0,
                  ),
                  onPressed: () {
                    setState();
                  })
            ],
          ),
          Text(
            this.resto.nomRestaurant,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(this.resto.description,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey
                )
              ),
              Text(
                this.resto.nbEtoiles.toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
              )
            ],
          ),
          Text(
            this.resto.ville,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          Text(
            "sur ${this.resto.notes.length.toString()} avis",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          //Ici le code d'affichage des images
          Row(
            children: [
              Text(
                "Commentaires",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                this.resto.notes.length.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200
                ),
              ),
              Icon(
                Icons.question_answer_rounded
              )
            ],
          ),
          //CommentaireUI(notes: this.resto.notes)
        ]
      )
    );
  }
  void setState() {// a suppr et remplacé par le lien à la BD
    isFavorite = !isFavorite;
  }
}



