// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodel/task_view_model.dart';
import 'detail.dart';

class Ecran1 extends StatelessWidget{

  //final List<Task> myTasks = Task.generateTask(5);
  late List<Task> myTasks = Task.generateTask(6);
  String tags='';

  Ecran1({super.key});

  @override
  Widget build(BuildContext context) {
    myTasks = context.watch<TaskViewModel>().liste;
    return ListView.builder(
        itemCount : myTasks.length,
        itemBuilder : (BuildContext context, int index){
          return Card(
            color: Colors.white,
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile (
              leading:CircleAvatar(backgroundColor: Colors.lightBlue,child:Text(myTasks[index].id.toString()),),
              title:Text(myTasks[index].title),
              subtitle: Text(myTasks[index].tags.join(" ")),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(task: myTasks[index])));                                                      },
              ),
            ),
          );
        }
    );
  }
}