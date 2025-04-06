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
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './viewmodels/taskviewmodels.dart';

import 'UI/connect.dart';
import 'UI/map.dart';
import 'UI/liste_resto.dart';
import 'UI/settings.dart';
import 'models/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://vicnhizlpnnchlerpqtr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZpY25oaXpscG5uY2hsZXJwcXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczOTAyMjcsImV4cCI6MjA1Mjk2NjIyN30.3IrL5w_zVj6vL9iD3wlpb-kAALGZvFN_TXZgYMPMzag',
  );

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
      // Vérifie si l'utilisateur est connecté
      final bool isAuthenticated = await AuthService.isUserLoggedIn(); // Remplace avec ta logique d'authentification

      final bool isLoggingIn = state.fullPath == '/connexion';

      // Si l'utilisateur n'est pas connecté et n'est pas sur la page de connexion, on le redirige
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
      ShellRoute(
        builder: (context, state, child) {
          return Home(child: child);
        },
        routes: [
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) =>  RestaurantUI(),
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
              path: '/restaurant/:id',  // Définition de la route avec 'id' comme paramètre dynamique
              builder: (BuildContext context, GoRouterState state) {
                final String osmId = state.params['id'] ?? '';  // Utiliser 'id' comme clé pour accéder au paramètre
                return RestaurantUI(osmId: osmId);  // Passer osmId à la page RestaurantUI
              }
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
            theme: MyTheme.light(), // Application dynamique du thème clair
            darkTheme: MyTheme.dark(),
            themeMode: notifier.isDark
                ? ThemeMode.dark
                : ThemeMode.light, // Gestion du mode sombre
          );
        },
      ),
    );
  }
}
