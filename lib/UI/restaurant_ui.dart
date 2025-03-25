import 'package:flutter/material.dart';
import 'package:my_little_food/UI/commentaire_ui.dart';
import 'package:my_little_food/UI/rating.dart';
import 'package:my_little_food/models/note.dart';
import 'package:my_little_food/models/restaurant.dart';

class RestaurantUI extends StatefulWidget {
  const RestaurantUI({super.key});

  @override
  _RestaurantUIState createState() => _RestaurantUIState();
}

class _RestaurantUIState extends State<RestaurantUI> {
  bool isFavorite = false; // Gère l'état du favori

  // Simule les données d'un restaurant (à remplacer avec les vraies données de la BD)
  late Restaurant resto = Restaurant(
    osmId: 1,
    nomRestaurant: "Le Délice Gourmand",
    description: "Un restaurant chaleureux avec des plats raffinés.",
    region: "Île-de-France",
    departement: "Paris",
    ville: "Paris",
    latitude: 48.8566,
    longitude: 2.3522,
    siteWeb: "www.ledelicegourmand.com",
    facebook: "facebook.com/ledelicegourmand",
    telRestaurant: "+33 1 23 45 67 89",
    nbEtoiles: 4,
    capacite: 50,
    fumeur: false,
    drive: true,
    aEmporter: true,
    livraison: true,
    vegetarien: true,
    horairesOuverture: "10h - 23h",
    cuisines: ["Française", "Italienne"],
    notes: [
      Note(
        mail: "client1@example.com",
        note: 5,
        commentaire: "Excellent restaurant, service impeccable !",
        date: "2025-03-22",
        nomAuteur: "Dupont",
        prenomAuteur: "Jean",
      ),
      Note(
        mail: "client2@example.com",
        note: 3,
        commentaire: "Bonne cuisine mais service un peu lent.",
        date: "2025-03-18",
        nomAuteur: "Martin",
        prenomAuteur: "Sophie",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ⭐️ Note et Favori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingScreen(), // Composant de notation
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 40.0,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),

            /// 🍽️ Nom du restaurant
            Text(
              resto.nomRestaurant,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            /// 📝 Description et étoiles
            Row(
              children: [
                Expanded(
                  child: Text(
                    resto.description,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  resto.nbEtoiles.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.star, color: Colors.yellowAccent),
              ],
            ),

            /// 📍 Ville
            Text(
              resto.ville,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),

            /// 📝 Nombre d'avis
            Text(
              "Sur ${resto.notes.length} avis",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            /// 🖼️ Placeholder pour les images (à remplacer par un vrai carousel)
            Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text("Ici les images du restaurant", style: TextStyle(color: Colors.black54)),
            ),
            const SizedBox(height: 10),

            /// 💬 Section commentaires
            Row(
              children: [
                const Text(
                  "Commentaires",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  "${resto.notes.length}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.question_answer_rounded),
              ],
            ),

            /// 📩 Liste des commentaires
            SizedBox(
              height: 300, // Définit une hauteur pour bien voir les commentaires
              child: CommentaireUI(notes: resto.notes),
            ),
          ],
        ),
      ),
    );
  }
}
