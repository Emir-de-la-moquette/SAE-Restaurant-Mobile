
import 'package:flutter/material.dart';
import '../models/class/note.dart';
import '../models/class/restaurant.dart';
import '../models/modelBD/restaurant_from_database.dart';
import 'package:go_router/go_router.dart';

class ListeResto extends StatefulWidget {
  @override
  _ListeRestoState createState() => _ListeRestoState();
}


class _ListeRestoState extends State<ListeResto> {
  final RestaurantDataBase restodata = RestaurantDataBase();
  late Future<List<Restaurant>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    // Appel de la méthode pour récupérer la liste des restaurants
    futureRestaurants = RestaurantDataBase().selectRestaurantTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Restaurants conseillés",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Restaurant>>(
            future: futureRestaurants,
            builder: (context, snapshot) {
              // Vérification de l'état de la connexion
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Afficher un indicateur de chargement
              }

              // Si une erreur se produit pendant la récupération des données
              if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              }

              // Si les données sont disponibles
              if (snapshot.hasData) {
                List<Restaurant> restos = snapshot.data!;  // Récupérer la liste des restaurants
                return ListView.builder(
                  itemCount: restos.length,
                  itemBuilder: (context, index) {
                    final restaurant = restos[index];
                    print(restaurant.cuisines);
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
                            Icons.favorite,
                            color: Colors.red,
                            size: 30.0,
                          ),
                          onPressed: () {

                            setState(() {
                              restaurant.toggleFavorite(); // Toggle the favorite status
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
                );
              }

              // Si aucune donnée n'est disponible
              return Center(child: Text('Aucun restaurant disponible'));
            },
          ),
        ),
      ],
    );
  }
}