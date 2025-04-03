import 'package:supabase_flutter/supabase_flutter.dart';
import '../class/note.dart';

class NoteDataBase{
  final database = Supabase.instance.client.from("noter");


  //creation
  Future createNote(Note newNote) async{
    await database.insert(newNote.toMap());
  }


  Future ConvertSelectToMap(data)async {
    List<Map<String, dynamic>> dataMapList = List<Map<String, dynamic>>.from(data);
    return dataMapList;
    // Afficher la nouvelle liste

  }


  Future selectNoteTotal() async{
   final response = await database.select();
   List<dynamic> data = response;
   List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
   return dataMap;
  }


  Future selectNoteFromResto(resto) async{
    final response = await database.select().eq("osmid", resto);
    List<dynamic> data = response;
    List<Map<String, dynamic>> dataMap = await ConvertSelectToMap(data);
    return dataMap;
  }



  //Update
  Future UpdateNote(Note oldNote,Note newNote) async{
    await database.update({
      "osmid":newNote.osmid ,
      "note":newNote.note,
      "mail": newNote.mail,
      "commentaire":newNote.commentaire ,
      "date": newNote.date,



    }).eq('emailpersonne',oldNote.mail).eq('osmid', oldNote.osmid);
  }

  //delect
  Future DelectNote(Note note) async{
    await database.delete().eq('emailpersonne',note.mail!).eq('osmid',note.osmid);
  }

  //a modifier pour que cela cible les bonnes notes


}