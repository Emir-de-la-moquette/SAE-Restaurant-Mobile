import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskViewModel extends ChangeNotifier{
  late List<Task> liste;
  //List<Task> l=[];

  Database? database;

  //TaskViewModel.database(this.database) {}

  TaskViewModel(){
    liste=[];
  }
  void addTask(Task task){
    liste.add(task);
    notifyListeners();
  }
  void generateTasks(){
    liste = Task.generateTask(70);
    notifyListeners();
  }

  void insertTask(Task t) {
    liste.add(t);
    notifyListeners();
  }

  void deleteTask(Task task) {
    liste.remove(task);
    notifyListeners();
  }

  void editTask(int id, String title, List<String> tags, int nbhours, int difficulty, String description) {
    Task taskToEdit = liste.elementAt(id);
    taskToEdit.title = title;
    taskToEdit.tags = tags;
    taskToEdit.nbhours = nbhours;
    taskToEdit.difficulty = difficulty;
    taskToEdit.description = description;
    debugPrint("Editing");
    notifyListeners();
  }
}