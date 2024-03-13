import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Esta clase representa un widget de barra de aplicación para la pantalla de inicio.
class HomeAppbar extends StatelessWidget {
  // Constructor constante para la clase HomeAppbar.
  const HomeAppbar({
    super.key,
  });

  @override
  // Método build para construir la interfaz de usuario del widget.
  Widget build(BuildContext context) {
    // Devuelve un Row (una fila horizontal) que contiene un Texto y un Spacer.
    return const Row(
      children: [
        // Texto que indica "¿Qué estás buscando hoy?".
        Text(
          "Que estas buscando hoy?",
          style: TextStyle(
            fontSize: 28, // Tamaño de fuente 28.
            fontWeight: FontWeight.bold, // Fuente en negrita.
            height: 1, // Altura del texto (1 significa la altura normal).
          ),
        ),
        // Spacer expande el espacio disponible entre los elementos en la fila.
        Spacer(),
      ],
    );
  }
}
