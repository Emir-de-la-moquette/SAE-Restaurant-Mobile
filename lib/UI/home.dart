import 'package:flutter/material.dart';
import 'package:td2/UI/addtask.dart';
import 'package:td2/UI/card1.dart';
import 'package:td2/UI/card2.dart';
import 'package:td2/UI/card3.dart';
import 'package:td2/UI/settings.dart';
import 'package:td2/UI/addtaskv2.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    Ecran1(),
    Ecran2(),
    Ecran3(),
    EcranSettings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App td2", style: Theme.of(context).textTheme.headlineLarge)
      ),
      body: Center(
        //child: Text("Debut td2", style: Theme.of(context).textTheme.bodyMedium,),
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Card 1'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Card 2'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Card 3'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          )
        ]
      ),
      floatingActionButton: _selectedIndex==0?FloatingActionButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddTaskV2(),
            )
          );
        },
        child: const Icon(Icons.add),
      )
      :const SizedBox.shrink(),
    );
  }}