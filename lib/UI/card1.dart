import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/models/detail.dart';
import 'package:td2/viewmodels/taskviewmodels.dart';
import 'package:td2/models/task.dart';

class Ecran1 extends StatelessWidget {
  late List<Task> tache ;//= Task.generateTask(70);
  String tags='';

  @override
  Widget build(BuildContext context) {
    tache=context.watch<TaskViewModel>().liste;
    return ListView.builder(
      itemCount: tache.length,
      itemBuilder: ( context, index) => Card(
        elevation: 6,
        child : ListTile(
        leading: CircleAvatar(
          backgroundColor : Colors.lightBlue,
          child: Text(tache[index].id.toString())),
          title : Text(tache[index].title),
          subtitle: Text(tache[index].description),
          onTap:() {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => Detail(task: tache[index])
              ),
            );
          }),
      ),
    );
  }
}