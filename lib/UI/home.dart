import 'package:flutter/material.dart';
import 'ecran_one.dart';
import 'ecran_two.dart';
import 'ecran_three.dart';
import 'ecran_four.dart';
import 'add_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> pages = <Widget>[Ecran1(), Ecran2(), Ecran3(), const Ecran4()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TD2", style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          ElevatedButton(
            onPressed: () => _logout(context),
            child: Text("Se déconnecter"),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        onTap: _cliqueSurItem,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 1'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 2'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 3'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTask()),
                );
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }

  void _cliqueSurItem(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('expiration');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
