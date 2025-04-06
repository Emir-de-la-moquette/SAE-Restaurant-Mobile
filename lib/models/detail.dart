import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/models/task.dart';
import 'package:td2/viewmodels/taskviewmodels.dart';
import 'package:td2/UI/edittask.dart';

class Detail extends StatelessWidget{
  final Task task;

  const Detail({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task : ${task.title}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Description : ${task.description}'),
            Text('Tags : ${task.tags}'),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.red
                ),
                onPressed: () {
                  context.read<TaskViewModel>().deleteTask(this.task);
                  Navigator.pop(context);
                },
                child: const Text("Supprimer"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.lightBlue
              ),
              onPressed: () {
                debugPrint("EditPressesd");
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => EditTask(task: task)
                  ),
                );
              },
              child: const Text("Modifier"),
            )
          ],
        ),
      ),

    );
  }
}