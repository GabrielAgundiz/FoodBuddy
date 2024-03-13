import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';

// Este widget representa un platillo individual en la lista de platillos.
class Platillo extends StatefulWidget {
  final Food food;

  // Constructor para el widget Platillo que recibe un objeto de tipo Food.
  const Platillo({Key? key, required this.food}) : super(key: key);

  @override
  _PlatilloState createState() => _PlatilloState();
}

class _PlatilloState extends State<Platillo> {
  @override
  Widget build(BuildContext context) {
    // GestureDetector detecta gestos como toques.
    return GestureDetector(
      // Al tocar el platillo, se navega a la pantalla de descripción.
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescScreen(food: widget.food),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            // Columna que contiene la imagen y la información del platillo.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contenedor para la imagen del platillo.
                Container(
                  width: double.infinity,
                  height: 99,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.food.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Nombre del platillo.
                Text(
                  widget.food.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Información de calorías y tiempo de preparación.
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Text(
                      "${widget.food.cal} Cal",
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
                      "${widget.food.time} Min",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Calificación y número de reseñas.
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow.shade500, size: 18),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.food.rate}/5",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "(${widget.food.reviews} Reviews)",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade400),
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
                    widget.food.isLiked = !widget.food.isLiked;
                  });
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(25, 25),
                ),
                iconSize: 20,
                // El icono cambia según si el platillo está marcado como "me gusta".
                icon: widget.food.isLiked
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
