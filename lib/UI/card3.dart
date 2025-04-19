import 'package:flutter/material.dart';

import '../api/MyAPI.dart';
import '../models/todo.dart';

class Ecran3 extends StatefulWidget {

  Ecran3({super.key});

  @override
  State<Ecran3> createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  final myAPI = MyAPI();
  late Future<List<Todo>> futurTodo;

  @override
  void initState(){
    super.initState();
    futurTodo = myAPI.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    //return Container(
    //color: Colors.black,
    //child: const Center(
    //child: Text("Ecran3"),
    //)
    //);
    return FutureBuilder(
        future: futurTodo,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.deepPurple,
                        child: Text(
                            snapshot.data?[index].id.toString() ?? ""),),
                      title: Text(snapshot.data?[index].title ?? ""),
                      subtitle: Checkbox(value: snapshot.data?[index].complete, onChanged: (bool? value){}),
                    )
                );
              },
            );
          }

          return Container();
        }
    );
  }
}