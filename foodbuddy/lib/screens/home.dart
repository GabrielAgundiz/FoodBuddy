import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/feed.dart';    // Importando la pantalla de alimentación
import 'package:foodbuddy/screens/restaurant.dart';
import 'package:foodbuddy/screens/search.dart';  // Importando la pantalla de búsqueda
import 'package:foodbuddy/screens/profile.dart';  // Importando la pantalla de perfil
import 'package:foodbuddy/screens/wishlist.dart'; // Importando la pantalla de lista de deseos

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; // Índice del elemento seleccionado en la barra de navegación inferior

  @override
  Widget build(BuildContext context) {
    final screens = [    // Lista de las pantallas a mostrar
      FeedPage(),
      const RestaurantPage(),
      const SearchPage(),
      SavesPage(),
      ProfilePage()
    ];

    Color selectedColor = Colors.green[400]!;  // Color del elemento seleccionado en la barra de navegación inferior
    Color unselectedColor = Colors.grey[600]!;  // Color del elemento no seleccionado en la barra de navegación inferior

    return Scaffold(    // Crea una nueva instancia de la clase Scaffold
      body: IndexedStack(    // Muestra una de las pantallas según el índice seleccionado
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(    // Barra de navegación inferior
        currentIndex: selectedIndex,    // Índice del elemento seleccionado
        onTap: (value) {    // Llamado cuando se selecciona un elemento
          setState(() {
            selectedIndex = value; // Actualiza el índice seleccionado
          });
        },
        elevation: 10,    // Sombra del elemento
        selectedItemColor: selectedColor,  // Color del elemento seleccionado
        unselectedItemColor: unselectedColor,  // Color del elemento no seleccionado
        backgroundColor: Colors.white.withOpacity(1), // Fondo de la barra de navegación inferior
        items: const <BottomNavigationBarItem>[    // Elementos de la barra de navegación inferior
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),    // Icono del elemento
            label: 'Inicio',   // Etiqueta del elemento
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),    // Icono del elemento
            label: 'Restaurantes',   // Etiqueta del elemento
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