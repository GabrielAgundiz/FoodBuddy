import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/widgets/food_card.dart'; // Importa el widget Platillo

class KetoScreen extends StatefulWidget {
  const KetoScreen({Key? key}) : super(key: key);

  @override
  State<KetoScreen> createState() => _KetoScreenState();
}

class _KetoScreenState extends State<KetoScreen> {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio
  List<Food> ketoFoods =
      []; // Lista para almacenar los alimentos vegetarianos

  @override
  void initState() {
    super.initState();
    _loadKetoFoods();
  }

  Future<void> _loadKetoFoods() async {
    List<Food> foods = await _foodService
        .getFoods(); // Obtener la lista de alimentos desde Firebase
    setState(() {
      ketoFoods = foods
          .where((food) => food.category == 'Keto')
          .toList(); // Filtrar la lista para obtener solo los alimentos vegetarianos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Keto', // Título de la barra de aplicación
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
                        15, // Espacio horizontal entre elementos de la cuadrícula
                    mainAxisSpacing:
                        20, // Espacio vertical entre elementos de la cuadrícula
                  ),
                  itemBuilder: (context, index) => Platillo(
                    // Constructor de cada elemento de la cuadrícula
                    food: ketoFoods[
                        index], // Pasa cada alimento vegetariano al widget Platillo
                  ),
                  itemCount: ketoFoods
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
