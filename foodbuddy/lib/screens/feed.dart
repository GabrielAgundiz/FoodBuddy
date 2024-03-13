import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodbuddy/screens/catscreen.dart';
import 'package:foodbuddy/screens/veganscreen.dart';
import 'package:foodbuddy/screens/vegetarianscreen.dart';
import 'package:foodbuddy/widgets/antojo.dart';
import 'package:foodbuddy/widgets/categorias.dart';
import 'package:foodbuddy/widgets/homeappbar.dart';
import 'package:foodbuddy/widgets/veganos.dart';
import 'package:foodbuddy/widgets/vegetarianos.dart';

// Página de alimentación (Feed)
class FeedPage extends StatelessWidget {
  String currentCat = "Todos"; // Categoría actualmente seleccionada
  final List<String> categories = [ // Lista de categorías disponibles
    'Todos',
    'Vegano',
    'Vegetariano',
    'Diabetico',
    'Fitness',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(fontWeight: FontWeight.bold),), // Título de la barra de aplicación
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(), // Barra de aplicación personalizada (widget HomeAppbar)
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://c.ndtvimg.com/2021-06/tau0bv3o_burger-king_625x300_24_June_21.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Categorias", // Título de la sección de categorías
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Categorias(categories: categories, currentCat: currentCat), // Widget para mostrar las categorías disponibles
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Para tu antojo", // Título de la sección "Para tu antojo"
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                        );
                      },
                      child: Text(
                        "Ver todos", // Etiqueta del botón "Ver todos"
                        style: TextStyle(color: Colors.green[400]), // Color del texto del botón
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Antojo(), 
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Para vegetarianos", // Título de la sección Vegetarianos
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VegetarianScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                        );
                      },
                      child: Text(
                        "Ver todos", // Etiqueta del botón "Ver todos"
                        style: TextStyle(color: Colors.green[400]), // Color del texto del botón
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Vegetarianos(),// Widget para mostrar alimentos según los vegetarianos
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Para veganos", // Título de la sección Veganos
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VeganScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                        );
                      },
                      child: Text(
                        "Ver todos", // Etiqueta del botón "Ver todos"
                        style: TextStyle(color: Colors.green[400]), // Color del texto del botón
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Veganos(),// Widget para mostrar alimentos según los vegetarianos
              ],
            ),
          ),
        ),
      ),
    );
  }
}
