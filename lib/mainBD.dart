import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:td2/viewmodels/settingsviewmodels.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './models/pageconnection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

  await Supabase.initialize(
    url: 'https://vicnhizlpnnchlerpqtr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZpY25oaXpscG5uY2hsZXJwcXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczOTAyMjcsImV4cCI6MjA1Mjk2NjIyN30.3IrL5w_zVj6vL9iD3wlpb-kAALGZvFN_TXZgYMPMzag',
  );

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    databaseFactory = databaseFactoryFfiWeb;
  }

  final database = openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, tags TEXT, nbhours INTEGER, difficulty INTEGER)',
        );
      }
  );
  final db = await database;
  runApp(MyApp(database: db,));
}

class MyApp extends StatelessWidget {
  late final Database database;

  MyApp({required this.database});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_){
              SettingViewModel settingViewModel = SettingViewModel();
              //getSettings est deja appelee dans le constructeur
              return settingViewModel;
            }),
        ChangeNotifierProvider(
            create: (_){
              SettingViewModel settingViewModel = SettingViewModel();
              //getSettings est deja appelee dans le constructeur
              return settingViewModel;
            }),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              title: 'TD2',
              home: HomePage()
          );
        },
      ),
    );
  }
}

