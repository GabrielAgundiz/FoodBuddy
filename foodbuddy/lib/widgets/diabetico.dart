import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';

// Widget Veganos que muestra una lista de alimentos.
class Diabeticos extends StatefulWidget {
  const Diabeticos({Key? key});

  @override
  _DiabeticosState createState() => _DiabeticosState();
}

class _DiabeticosState extends State<Diabeticos> {
  @override
  Widget build(BuildContext context) {
    // Filtrar la lista de alimentos para obtener solo los Diabeticos
    final List<Food> vegetarianFoods =
        foods.where((food) => food.category == 'Diabetico').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SingleChildScrollView permite desplazar la fila de alimentos horizontalmente.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Desplazamiento horizontal.
          child: Row(
            children: List.generate(
              vegetarianFoods.length,
              (index) => GestureDetector(
                // Al tocar un alimento, se navega a la pantalla de descripción del alimento.
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DescScreen(food: vegetarianFoods[index]),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(right: 10), // Margen derecho para separar los alimentos.
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
                            height: 130, // Altura fija para la imagen del alimento.
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15), // Bordes redondeados de la imagen.
                              image: DecorationImage(
                                image: NetworkImage(
                                  vegetarianFoods[index]
                                      .image, // URL de la imagen del alimento.
                                ),
                                fit: BoxFit.fill, // Ajuste de la imagen para llenar el contenedor.
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Nombre del alimento.
                          Text(
                            vegetarianFoods[index].name,
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
                                "${vegetarianFoods[index].cal} Cal",
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
                                "${vegetarianFoods[index].time} Min",
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
                              vegetarianFoods[index].isLiked =
                                  !vegetarianFoods[index].isLiked;
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
                            vegetarianFoods[index].isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: vegetarianFoods[index].isLiked
                                ? Colors.red
                                : null,
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
