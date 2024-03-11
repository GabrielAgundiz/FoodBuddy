import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/feed.dart';
import 'package:foodbuddy/screens/search.dart';
import 'package:foodbuddy/screens/profile.dart';
import 'package:foodbuddy/screens/notifies.dart';
import 'package:foodbuddy/screens/wishlist.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [FeedPage(), SearchPage(), SavesPage(), ProfilePage()];
    Color selectedColor = Colors.green[400]!;
    Color unselectedColor = Colors.grey[600]!;
    
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 10,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        backgroundColor: Colors.white.withOpacity(1), // Agrega esta linea
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}