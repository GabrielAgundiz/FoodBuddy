import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/widgets/food_card.dart'; // Importa el widget Platillo

// Página de los alimentos guardados como favoritos
class SavesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos', // Título de la barra de aplicación
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                GridView.count(
                  // GridView para mostrar los alimentos guardados en forma de cuadrícula
                  shrinkWrap: true, // Ajusta el tamaño del GridView al contenido
                  physics: const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento dentro del GridView
                  crossAxisCount: 2, // Número de elementos en cada fila de la cuadrícula
                  crossAxisSpacing: 20, // Espacio horizontal entre elementos de la cuadrícula
                  mainAxisSpacing: 20, // Espacio vertical entre elementos de la cuadrícula
                  children: foods
                      .where((food) => food.isLiked) // Filtra los alimentos marcados como favoritos
                      .map((food) => Platillo( // Convierte los alimentos en widgets Platillo
                            food: food, // Pasa cada alimento al widget Platillo
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
