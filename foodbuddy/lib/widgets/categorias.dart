import 'package:flutter/material.dart';

// Definición del color primario utilizado en las categorías.
const kprimaryColor = Color(0xFF5DB075);

// Widget Categorias que muestra una lista de categorías.
class Categorias extends StatelessWidget {
  // Constructor para el widget Categorias.
  const Categorias({
    Key? key,
    required this.categories, // Lista de categorías.
    required this.currentCat, // Categoría actual seleccionada.
    required this.updateCurrentCategory, // Función para actualizar la categoría actual.
  }) : super(key: key);

  final List<String> categories; // Lista de categorías.
  final String currentCat; // Categoría actual seleccionada.
  final Function(String) updateCurrentCategory; // Función para actualizar la categoría actual.

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView permite desplazar la fila de categorías horizontalmente.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Desplazamiento horizontal.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          height: 50, // Altura fija de la fila de categorías.
          child: Row(
            children: List.generate(
              categories.length,
              (index) => GestureDetector(
                onTap: () {
                  updateCurrentCategory(categories[index]); // Actualiza la categoría actual al hacer clic.
                },
                child: Container(
                  // Contenedor para cada categoría.
                  decoration: BoxDecoration(
                    color: currentCat == categories[index] // Cambia el color de fondo si la categoría coincide con la actual.
                        ? kprimaryColor // Si es la categoría actual, usa el color primario.
                        : Colors.white, // Si no, usa el color blanco.
                    borderRadius: BorderRadius.circular(25), // Bordes redondeados del contenedor.
                    boxShadow: [
                      // Sombra para efecto visual.
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Color de sombra con opacidad.
                        blurRadius: 2, // Radio de desenfoque.
                        spreadRadius: 1, // Radio de expansión de la sombra.
                        offset: const Offset(0, 3), // Desplazamiento de la sombra.
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25, // Espaciado horizontal dentro del contenedor.
                    vertical: 10, // Espaciado vertical dentro del contenedor.
                  ),
                  margin: const EdgeInsets.only(right: 20), // Margen derecho para separar las categorías.
                  child: Text(
                    categories[index], // Texto de la categoría.
                    style: TextStyle(
                      color: currentCat == categories[index]
                          ? Colors.white // Si es la categoría actual, usa color blanco para el texto.
                          : const Color.fromARGB(255, 0, 0, 0), // Si no, usa color negro.
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
