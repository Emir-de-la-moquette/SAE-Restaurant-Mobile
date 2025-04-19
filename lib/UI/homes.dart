import 'package:flutter/material.dart';
import 'package:td2/UI/image_picker.dart';

import '../models/class/note.dart';
import '../models/class/restaurant.dart';
import './rating.dart';
import './commentaire_ui.dart';
import './map.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  _RestaurantUIState createState() => _RestaurantUIState();
}

class _RestaurantUIState extends State<Homes> {
  final TextEditingController _commentController = TextEditingController();
  double _userRating = 0; // Valeur par défaut de la note

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

  /// 🔹 Fonction pour ajouter un commentaire
  void _ajouterCommentaire() {
    String commentaire = _commentController.text.trim();

    if (commentaire.isNotEmpty && _userRating > 0) {
      setState(() {
        resto.notes.add(Note(
          mail:
              "nouveau.client@example.com", // À remplacer par le vrai utilisateur
          note: _userRating.toInt(),
          commentaire: commentaire,
          date: DateTime.now().toString().split(' ')[0], // Date du jour
          nomAuteur: "Nouveau",
          prenomAuteur: "Client",
        ));
        _commentController.clear();
        _userRating = 0; // Réinitialiser la note
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Favori

            IconButton(
              icon: Icon(
                Icons.favorite,
                //todo
                //restaurant.isFavorite() ? Icons.favorite : Icons.favorite_border,
                // color: restaurant.isFavorite() ? Colors.red : Colors.grey,
                color: Colors.red,
                size: 40.0,
              ),
              onPressed: () {
                setState(() {
                  this.resto.toggleFavorite() ;
                });
              },
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 10),
            Container(
              height: 200,
              child: ImagePickerResto(osmId :this.resto.osmId),
            ),
            const SizedBox(height: 36),


            SizedBox(
              height: 500, // Hauteur fixe pour éviter les erreurs de dimensionnement
              child: Mapmoi(lon:resto.longitude,lat:resto.latitude,nom:resto.nomRestaurant),
            ),

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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.question_answer_rounded),
              ],
            ),

            /// 📝 **Formulaire d'ajout de commentaire**
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ⭐ **Sélection de la note**
                  const Text("Note :",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  RatingScreen(
                    onRatingUpdate: (rating) {
                      setState(() {
                        _userRating = rating; // Stocke la note sélectionnée
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  /// 📝 **Champ de texte pour le commentaire**
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Écrire un commentaire...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),

                  /// ✅ **Bouton d'envoi du commentaire**
                  ElevatedButton(
                    onPressed: _ajouterCommentaire,
                    child: const Text("Envoyer"),
                  ),
                ],
              ),
            ),

            /// 📩 Liste des commentaires
            SizedBox(
              height:
                  300, // Définit une hauteur pour bien voir les commentaires
              child: CommentaireUI(notes: resto.notes),
            ),
          ],
        ),
      ),
    );
  }
}
