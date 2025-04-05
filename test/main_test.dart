import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:td2/main.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() async {
    // Initialisation pour sqflite en environnement de test
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('App démarre et affiche la page de connexion', (WidgetTester tester) async {
    final database = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await tester.pumpWidget(MyApp(database: database));

    await tester.pumpAndSettle();

    // Vérifie qu'on est bien sur la page de connexion
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('Navigation vers la page de favoris via GoRouter', (WidgetTester tester) async {
    final database = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await tester.pumpWidget(MyApp(database: database));
    await tester.pumpAndSettle();

    // Simule une navigation
    final BuildContext context = tester.element(find.byType(MyApp));
    GoRouter.of(context).go('/favoris');

    await tester.pumpAndSettle();

    expect(find.text('Favoris'), findsOneWidget); // À adapter selon le contenu réel
  });
}