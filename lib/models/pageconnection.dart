
import 'package:flutter/material.dart';
import 'package:td2/models/modelBD/favory_from_database.dart';
import 'modelBD/note_from_database.dart';
import 'class/note.dart';

import 'modelBD/restaurant_from_database.dart';
import 'class/restaurant.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final notesDatabase =NoteDataBase();

 final restaurantDatabase =RestaurantDataBase();
 final favoriesDataBase =FavoriesDataBase();

 final noteControleur = TextEditingController();
 final mailControleur = TextEditingController();
 final commentaireControleur = TextEditingController();

 List<Map<String, dynamic>> dataMapNote = [];
 List<Map<String, dynamic>> dataMapResto = [];
 List<Map<String, dynamic>> dataMapFav = [];

 @override
 void initState() {
   super.initState();
   loadData();
 }

 Future<void> loadData() async {
   try {

     dataMapNote = await notesDatabase.selectNoteTotal();
     dataMapResto = await restaurantDatabase.selectRestaurantTotal();
     dataMapFav = await favoriesDataBase.selectFavTotal();

   } catch (e) {
     print('Erreur lors de la récupération des données: $e');
   }
 }


 void addNewNote(){
 showDialog(
     context: context,
     builder: (context) => AlertDialog(
       title: const Text("Nouvelle Note"),

       content: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           TextField(
             controller: mailControleur,
             decoration: const InputDecoration(labelText: "Email"),
           ),
           TextField(
             controller: noteControleur,
             decoration: const InputDecoration(labelText: "Note"),
           ),
           TextField(
             controller: commentaireControleur,
             decoration: const InputDecoration(labelText: "Commentaire"),
           ),
         ],
       ),
       actions: [

         //cancel button
         TextButton(
           onPressed: (){
             Navigator.pop(context);
             mailControleur.clear();
             noteControleur.clear();
             commentaireControleur.clear();
           },
         child: const Text("Cancel"),
         ),

         //save
         TextButton(
           onPressed: (){
             final newNote = Note(
                 osmid: 0,
                 mail: mailControleur.text,
                 note: int.parse(noteControleur.text),
                 commentaire: commentaireControleur.text,
                 date: DateTime.now().toString(),
             );

             notesDatabase.createNote(newNote);

             Navigator.pop(context);
             noteControleur.clear();
           },
           child: const Text("Save"),
         ),
       ],

    ),
    );
 }


  @override
  Widget build(BuildContext context) {
    bool isEmpty = dataMapNote.isEmpty && dataMapResto.isEmpty && dataMapFav.isEmpty;
    return Scaffold(
      appBar:AppBar(title: const Text("LES NOTES "),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addNewNote,
              child: const Icon(Icons.add),
      ),
      body:isEmpty
          ? Center(child: CircularProgressIndicator()) // Affiche un indicateur de chargement si vide
          :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Si dataMapNote n'est pas vide, afficher la liste
            if (dataMapNote.isNotEmpty)
              Container(
                height: 300, // Définir une hauteur fixe ou ajuster selon vos besoins
                child: ListView.builder(
                  shrinkWrap: true,  // Pour empêcher ListView de prendre toute la place
                  itemCount: dataMapNote.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = dataMapNote[index];
                    List<String> keys = item.keys.toList();
                    return ListTile(
                      title: Text(keys.join(", ")),
                      subtitle: Text(item.toString()),
                    );
                  },
                ),
              ),

            // Si dataMapResto n'est pas vide, afficher la liste
            if (dataMapResto.isNotEmpty)
              Container(
                height: 300, // Définir une hauteur fixe ou ajuster selon vos besoins
                child: ListView.builder(
                  shrinkWrap: true,  // Pour empêcher ListView de prendre toute la place
                  itemCount: dataMapResto.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = dataMapResto[index];
                    List<String> keys = item.keys.toList();
                    return ListTile(
                      title: Text(keys.join(", ")),
                      subtitle: Text(item.toString()),
                    );
                  },
                ),
              ),

            // Si dataMapFav n'est pas vide, afficher la liste
            if (dataMapFav.isNotEmpty)
              Container(
                height: 300, // Définir une hauteur fixe ou ajuster selon vos besoins
                child: ListView.builder(
                  shrinkWrap: true,  // Pour empêcher ListView de prendre toute la place
                  itemCount: dataMapFav.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = dataMapFav[index];
                    List<String> keys = item.keys.toList();
                    return ListTile(
                      title: Text(keys.join(", ")),
                      subtitle: Text(item.toString()),
                    );
                  },
                ),
              ),
          ],
        ),
      )
                          );
                        }
}