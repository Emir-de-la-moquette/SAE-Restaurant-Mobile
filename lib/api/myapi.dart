import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/task.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

class MyAPI{

  /* Pour l'écran n°2 basé sur le fichier JSON**/
  Future<List<Task>> getTasks() async{
    await Future.delayed(const Duration(seconds: 1));
    final dataString = await _loadAsset('data/tasks.json');
    final json = jsonDecode(dataString);
    if (json.isNotEmpty){
      final tasks = <Task>[];
      json["tasks"].forEach((element){
        tasks.add(Task.fromJson(element));
        });
      return tasks;
    }else{
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  /* Pour l'écran n°3 basé sur l'API REST http**/
  Future<List<Todo>> getTodos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200){

      final List<dynamic> json = jsonDecode(response.body);

      final todos = <Todo>[];
      for (var element in json) {
        todos.add(Todo.fromJson(element));
      }

      return todos;
    }else{

      throw Exception('Failed to load todos');
    }
  }

}