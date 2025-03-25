import 'package:flutter/material.dart';
import 'package:my_little_food/models/note.dart';

class CommentaireUI extends StatelessWidget {
  final List<Note> notes;

  const CommentaireUI({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Text(
                  notes[index].getInitiale(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${notes[index].prenomAuteur} ${notes[index].nomAuteur}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notes[index].getDateDiff(),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              subtitle: Text(
                notes[index].commentaire,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
