import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/service/food_service.dart'; // Importa el servicio FoodService

// Widget Veganos que muestra una lista de alimentos.
class Veganos extends StatefulWidget {
  const Veganos({Key? key});

  @override
  _VeganosState createState() => _VeganosState();
}

class _VeganosState extends State<Veganos> {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio
  List<Food> veganFoods = []; // Lista para almacenar los alimentos veganos

  @override
  void initState() {
    super.initState();
    _loadVeganFoods();
  }

  Future<void> _loadVeganFoods() async {
    List<Food> fetchedFoods = await _foodService
        .getFoods(); // Obtener la lista de alimentos desde Firebase
    setState(() {
      veganFoods = fetchedFoods
          .where((food) => food.category == 'Vegano')
          .toList(); // Filtrar los alimentos veganos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SingleChildScrollView permite desplazar la fila de alimentos horizontalmente.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Desplazamiento horizontal.
          child: Row(
            children: List.generate(
              veganFoods.length,
              (index) => GestureDetector(
                // Al tocar un alimento, se navega a la pantalla de descripción del alimento.
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescScreen(food: veganFoods[index]),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 10), // Margen derecho para separar los alimentos.
                  width: 200, // Ancho del contenedor que contiene el alimento.
                  child: Stack(
                    children: [
                      // Columna que contiene la imagen y la información del alimento.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contenedor para la imagen del alimento.
                          Container(
                            width: double.infinity,
                            height:
                                130, // Altura fija para la imagen del alimento.
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Bordes redondeados de la imagen.
                              image: DecorationImage(
                                image: NetworkImage(
                                  veganFoods[index]
                                      .image, // URL de la imagen del alimento.
                                ),
                                fit: BoxFit
                                    .fill, // Ajuste de la imagen para llenar el contenedor.
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Nombre del alimento.
                          Text(
                            veganFoods[index].name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Información nutricional del alimento (calorías y tiempo de preparación).
                          Row(
                            children: [
                              const Icon(
                                Icons.local_fire_department,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${veganFoods[index].cal} Cal",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                " • ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Icon(
                                Icons.schedule,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${veganFoods[index].time} Min",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Botón de "Me gusta" en la esquina superior derecha.
                      Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              veganFoods[index].isLiked =
                                  !veganFoods[index].isLiked;
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Color de fondo del botón.
                            fixedSize:
                                const Size(25, 25), // Tamaño fijo del botón.
                          ),
                          iconSize: 20, // Tamaño del icono del botón.
                          icon: Icon(
                            veganFoods[index].isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                veganFoods[index].isLiked ? Colors.red : null,
                          ), // Icono del botón.
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
