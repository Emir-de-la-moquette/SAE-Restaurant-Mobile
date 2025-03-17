import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Consult extends StatelessWidget{
  final Todo todo;

  const Consult({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${todo.title} detail'),
      ),
      body: Center(
        child: Column(
          children: [
      
            Card(
              color: Colors.orangeAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading:(const Icon(Icons.key)),
                title:const Text('Identifiant',style: TextStyle(fontFamily: "cursiva"),),
                subtitle: Text( '${todo.id}'),
              ),
            ),
      
            Card(
              color: Colors.orangeAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading:(const Icon(Icons.title)),
                title:const Text('Titre de la tache'),
                subtitle: Text( todo.title),
              ),
            ),
      
            Card(
              color: Colors.orangeAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading:(const Icon(Icons.task_alt)),
                title:const Text("Effectuée ? "),
                trailing:Checkbox(value: todo.completed, onChanged: (bool? value) {  }),
              ),
            ),

            Image.asset("assets/images/funny-picture-of-a-llama-with-a-shaved-body-and-unshaved-head-that-we-found-on-pinterest.jpeg"),
            SvgPicture.asset("assets/images/Generic_Logo.svg")
          ],
        ),
      ),
    );
  }

}