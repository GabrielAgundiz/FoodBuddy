import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/widgets/food_card.dart'; // Importa el widget Platillo

// Pantalla de categorías
class VeganScreen extends StatefulWidget {
  const VeganScreen({super.key});

  @override
  State<VeganScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<VeganScreen> {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio
  List<Food> veganFoods = [];

  @override
  void initState() {
    super.initState();
    _loadDiabeticFoods();
  }

  Future<void> _loadDiabeticFoods() async {
    List<Food> foods = await _foodService
        .getFoods(); // Obtener la lista de alimentos desde Firebase
    setState(() {
      veganFoods = foods
          .where((food) => food.category == 'Vegano')
          .toList(); // Filtrar la lista para obtener solo los alimentos vegetarianos
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar la lista de alimentos para obtener solo los veganos
    //final List<Food> veganFoods = foods.where((food) => food.category == 'Vegano').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Para veganos', // Título de la barra de aplicación
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
                ), // Espaciado superior
                GridView.builder(
                  // GridView para mostrar los alimentos en forma de cuadrícula
                  shrinkWrap:
                      true, // Ajusta el tamaño del GridView al contenido
                  physics:
                      const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento dentro del GridView
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    food: veganFoods[
                        index], // Pasa cada alimento vegano al widget Platillo
                  ),
                  itemCount: veganFoods
                      .length, // Número total de elementos en la cuadrícula
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
