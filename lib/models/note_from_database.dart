import 'package:supabase_flutter/supabase_flutter.dart';
import './note.dart';

class NoteDataBase{
  final database = Supabase.instance.client.from("noter");


  //creation
  Future createNote(Note newNote) async{
    await database.insert(newNote.toMap());
  }

  //read
  final stream =Supabase.instance.client.from("noter").stream(primaryKey: ['emailpersonne'],
  ).map((data) => data.map((noteMap) => Note.fromMap(noteMap))).toList();

  //Update
  Future UpdateNote(Note oldNote,Note newNote) async{
    await database.update({
      "note":newNote.note,
      "mail": newNote.mail,
      "commentaire":newNote.commentaire ,
      "date": newNote.date,
      "nomAuteur":newNote.nomAuteur ,
      "prenomAuteur":newNote.prenomAuteur  ,

    }).eq('emailpersonne',oldNote.mail!);
  }

  //delect
  Future DelectNote(Note note) async{
    await database.delete().eq('emailpersonne',note.mail!);
  }

  //a modifier pour que cela cible les bonnes notes


}