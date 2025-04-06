import 'package:flutter_test/flutter_test.dart';
import 'package:td2/models/class/restaurant.dart';
import 'package:td2/models/class/note.dart';

void main() {
  group('Restaurant', () {
    late Restaurant restaurant;

    setUp(() {
      restaurant = Restaurant(
        osmId: 123456,
        nomRestaurant: "Chez GPT",
        description: "Un resto IA top qualité",
        region: "Occitanie",
        departement: "Hérault",
        ville: "Montpellier",
        latitude: 43.6119,
        longitude: 3.8777,
        siteWeb: "https://chezgpt.fr",
        facebook: "https://fb.com/chezgpt",
        telRestaurant: "0102030405",
        nbEtoiles: 4.5,
        capacite: 80,
        fumeur: false,
        drive: true,
        aEmporter: true,
        livraison: true,
        vegetarien: true,
        horairesOuverture: "Lun-Dim 11h-22h",
        cuisines: ["Française", "Fusion"],
        notes: [
          Note(
            mail: "test@test.com",
            note: 5,
            commentaire: "Excellent !",
            date: "2024-04-01",
            nomAuteur: "Doe",
            prenomAuteur: "John",
          ),
        ],
      );
    });

    test('localiser retourne ville, département, région', () {
      expect(restaurant.localiser(), equals("Montpellier, Hérault, Occitanie"));
    });

    test('getNbCommentaire retourne le bon nombre de commentaires', () {
      expect(restaurant.getNbCommentaire(), equals(1));

      restaurant.notes.add(
        Note(
          mail: "jane@example.com",
          note: 4,
          commentaire: "Très bon !",
          date: "2024-03-15",
          nomAuteur: "Jane",
          prenomAuteur: "Doe",
        ),
      );

      expect(restaurant.getNbCommentaire(), equals(2));
    });

    test('setState inverse correctement isFavorite', () {
      expect(restaurant.isFavorite, isFalse);

      restaurant.toggleFavorite();
      expect(restaurant.isFavorite, isTrue);

      restaurant.toggleFavorite();
      expect(restaurant.isFavorite, isFalse);
    });
  });
}
