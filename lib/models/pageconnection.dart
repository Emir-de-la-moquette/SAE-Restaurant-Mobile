import 'package:flutter/material.dart';
import './note_from_database.dart';
import './note.dart';


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
 final nomAuteurControleur = TextEditingController();
 final prenomAuteurControleur = TextEditingController();


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
           TextField(
             controller: nomAuteurControleur,
             decoration: const InputDecoration(labelText: "Nom de l'auteur"),
           ),
           TextField(
             controller: prenomAuteurControleur,
             decoration: const InputDecoration(labelText: "Prénom de l'auteur"),
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
             nomAuteurControleur.clear();
             prenomAuteurControleur.clear();
           },
         child: const Text("Cancel"),
         ),

         //save
         TextButton(
           onPressed: (){
             final newNote = Note(
                 mail: mailControleur.text,
                 note: int.parse(noteControleur.text),
                 commentaire: commentaireControleur.text,
                 date: DateTime.now().toString(),
                 nomAuteur: nomAuteurControleur.text,
                 prenomAuteur: prenomAuteurControleur.text,
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

      body: StreamBuilder(
        stream: notesDatabase.get_stream(),
        builder: (context,snapshot){
          if ( !snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;
          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context,index){
                final note = notes[index];

                return ListTile(
                  leading: CircleAvatar(
                  child: Text('C')),
                  title: Text('Headline' + note.note.toString()),
                  subtitle: Text(
                      note.commentaire
                  ),
                  trailing: Icon(Icons.favorite_rounded),
                  isThreeLine: true,
                );

              },
          );
        }

      ),
    );
  }
}