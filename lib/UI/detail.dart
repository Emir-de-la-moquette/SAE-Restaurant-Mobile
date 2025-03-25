import 'package:flutter/material.dart';
import 'package:td2/models/task.dart';

class Detail extends StatelessWidget {
  final Task task;
  
  const Detail({required this.task});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text('description : ${task.description}'),
            Text('tags : ${task.tags.join(" ")}'),
            Text('tags : ${task.tags.join(" ")}'),
          ],
        ),
      )
    );
  }
}