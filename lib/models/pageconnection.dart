
import 'package:flutter/material.dart';
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

 final noteControleur = TextEditingController();
 final mailControleur = TextEditingController();
 final commentaireControleur = TextEditingController();

 List<Map<String, dynamic>> dataMap = [];

 @override
 void initState() {
   super.initState();
   loadData();
 }

 Future<void> loadData() async {
   try {

    dataMap = await notesDatabase.selectNoteTotal();

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
    return Scaffold(
      appBar:AppBar(title: const Text("LES NOTES "),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addNewNote,
              child: const Icon(Icons.add),
      ),
      body:dataMap.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: dataMap.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> item = dataMap[index];
              List<String> keys = item.keys.toList();

              return ListTile(
                title: Text(keys.join(", ")),
                subtitle: Text(item.toString()),
          );
        },
      )
    );
  }
}