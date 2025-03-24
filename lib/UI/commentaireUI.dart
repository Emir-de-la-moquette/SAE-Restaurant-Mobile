import 'package:flutter/material.dart';
import 'package:my_little_food/models/note.dart';

class CommentaireUI extends StatelessWidget {
  //final List<Task> myTasks = Task.generateTask(5);
  late List<Note> notes;
  String tags = '';

  CommentaireUI({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Text(this.notes[index].getInitiale()),
              ),
              title: Row(children: [
                Text(
                    "${this.notes[index].prenomAuteur} ${this.notes[index].nomAuteur}")
              ]),
              subtitle: Text(
                this.notes[index].commentaire,
                style: TextStyle(

                ),
              ),
            ),
          );
        });
  }
}
