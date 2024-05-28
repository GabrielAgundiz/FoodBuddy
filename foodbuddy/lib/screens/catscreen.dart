import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/widgets/food_card.dart'; // Importa el widget Platillo

// Pantalla de categorías
// Pantalla de categorías
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Para tu antojo', // Título de la barra de aplicación
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Food>>(
              future: _foodService
                  .getFoods(), // Obtener los alimentos desde Firebase
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Food> foods =
                      snapshot.data!; // Lista de alimentos obtenidos
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      GridView.builder(
                        // GridView para mostrar los alimentos en forma de cuadrícula
                        shrinkWrap:
                            true, // Ajusta el tamaño del GridView al contenido
                        physics:
                            const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento dentro del GridView
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // Configuración de la cuadrícula
                          crossAxisCount:
                              2, // Número de elementos en cada fila de la cuadrícula
                          crossAxisSpacing:
                              20, // Espacio horizontal entre elementos de la cuadrícula
                          mainAxisSpacing:
                              20, // Espacio vertical entre elementos de la cuadrícula
                        ),
                        itemBuilder: (context, index) => Platillo(
                          // Constructor de cada elemento de la cuadrícula
                          food: foods[
                              index], // Pasa cada alimento al widget Platillo
                        ),
                        itemCount: foods
                            .length, // Número total de elementos en la cuadrícula
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
