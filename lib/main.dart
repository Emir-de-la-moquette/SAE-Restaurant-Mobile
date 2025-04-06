import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:td2/UI/home.dart';
import 'package:td2/UI/liste_favori.dart';
import 'package:td2/UI/mytheme.dart';
import 'package:td2/UI/restaurant_ui.dart';
import 'package:td2/viewmodels/settingsviewmodels.dart';
import 'package:td2/viewmodels/taskviewmodels.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'UI/card1.dart';
import 'UI/card2.dart';
//import 'UI/card3.dart';
import 'UI/connect.dart';
import 'UI/map.dart';
import 'UI/liste_resto.dart';
import 'UI/settings.dart';
import 'models/AuthService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

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
    },
  );

  final db = await database;
  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  late final Database database;
  final GoRouter router = GoRouter(
    initialLocation: '/connexion',
    redirect: (context, state) async {
      // verif la connexion
      final bool isAuthenticated = await AuthService.isUserLoggedIn();

      final bool isLoggingIn = state.fullPath == '/connexion';

      // redirection si pas connecté
      if (!isAuthenticated && !isLoggingIn) {
        return '/connexion';
      }
      return null;
    },
    routes: [
      GoRoute(
        name: 'connexion',
        path: '/connexion',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: 'creercompte',
        path: '/signup',
        builder: (context, state) => signupScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return Home(child: child);
        },
        routes: [
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) => RestaurantUI(),
          ),
          GoRoute(
            name: 'favoris',
            path: '/favoris',
            builder: (context, state) => ListeFavori(),
          ),
          GoRoute(
            name: 'restaurants',
            path: '/restaurant',
            builder: (context, state) => ListeResto(),
          ),
          GoRoute(
            name: 'restaurant',
            path: '/restaurant/:id',
            builder: (context, state) => RestaurantUI(),
          ),
          GoRoute(
            name: 'images',
            path: '/images',
            builder: (context, state) => Ecran2(),
          ),
          GoRoute(
            name: 'profil',
            path: '/profil',
            builder: (context, state) => EcranSettings(),
          ),
        ],
      ),
    ],
  );

  MyApp({required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            SettingViewModel settingViewModel = SettingViewModel();
            return settingViewModel;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            TaskViewModel taskViewModel = TaskViewModel();
            taskViewModel.generateTasks();
            return taskViewModel;
          },
        ),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, SettingViewModel notifier, child) {
          return MaterialApp.router(
            title: 'test',
            routerConfig: router,
            theme: MyTheme.light(),
            darkTheme: MyTheme.dark(),
            themeMode: notifier.isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
