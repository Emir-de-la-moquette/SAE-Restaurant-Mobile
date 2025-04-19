import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/note.dart';

class NoteDataBase{
  final database = Supabase.instance.client.from("noter");


  //creation
  Future createNote(Note newNote) async{
    await database.insert(newNote.toMap());
  }



  //Update
  Future UpdateNote(Note oldNote,Note newNote,osmid) async{
    await database.update({
      "note":newNote.note,
      "mail": newNote.mail,
      "commentaire":newNote.commentaire ,
      "date": newNote.date,

    }).eq('emailpersonne',oldNote.mail).eq('osmid',osmid);
  }

  //delect
  Future DelectNote(Note note,osmid) async{
    await database.delete().eq('emailpersonne',note.mail!).eq('osmid',osmid);
  }

  //a modifier pour que cela cible les bonnes notes




  Future getCommentaire(mail) async{
    final response = await database.select().eq("emailpersonne", mail);
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }


  Future selectNoteTotal() async{
    final response = await database.select();
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }


  Future selectNoteFromResto(idresto) async{
    final response = await database.select().eq("osmid", idresto);
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }

  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;
    // Afficher la nouvelle liste

  }



  Future ConvertSelectToRestaurant(data)async {
    List<Map<String, dynamic>> dataMapList = await ConvertSelectToMap(data);
    List<Note> listeNote = [];
    for (var note in dataMapList) {
      Note rest = Note.fromMap(note);
      listeNote.add(rest);
    }
    return listeNote;

  }

}