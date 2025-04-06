import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/class/note.dart';
import '../models/class/restaurant.dart';

class ListeFavori extends StatefulWidget {
  @override
  _ListeFavoriState createState() => _ListeFavoriState();
}

class _ListeFavoriState extends State<ListeFavori> {
  final List<Restaurant> restos = [
    Restaurant(
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
      ],
    ),Restaurant(
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
      ],
    ),Restaurant(
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
      ],
    ),Restaurant(
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
      ],
    ),Restaurant(
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
      ],
    )
    // Ajoute d'autres restaurants si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Vos Favoris",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: restos.length,
            itemBuilder: (context, index) {
              final restaurant = restos[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.image, color: Colors.black54),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.nomRestaurant,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${restaurant.nbEtoiles} ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.star, color: Colors.yellowAccent),
                    ],
                  ),
                  subtitle: Text(
                    restaurant.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: restaurant.isFavorite ? Colors.red : Colors.grey,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        restaurant.isFavorite = !restaurant.isFavorite;
                      });
                    },
                  ),
                  onTap: (){
                    //redirection vers RestaurantUI de ce resto
                    context.go('/restaurant/${restaurant.osmId}');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
