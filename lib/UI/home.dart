import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/UI/mytheme.dart';
import 'package:go_router/go_router.dart';
import 'package:td2/viewmodels/settingsviewmodels.dart';

class Home extends StatefulWidget {
  final Widget child;
  const Home({Key? key, required this.child}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<String> routes = [
    '/',
    '/restaurant',
    '/favoris',
    '/profil'
  ];

  void _onItemTapped(int index) {
    context.go(routes[index]);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<SettingViewModel>().isDark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              MyTheme.getTasseImage(isDarkMode),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('Paramètres'),
          ],
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Restaurants'),
          BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined), label: 'Mes Images'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
