import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material.

void main() {
  runApp(MaterialApp(
    home:
        NotifiesPage(), // Define NotifiesPage como la página principal de la aplicación.
  ));
}

class NotifiesPage extends StatefulWidget {
  NotifiesPage({Key? key})
      : super(key: key); // Constructor de la clase NotifiesPage.

  @override
  _NotifiesPageState createState() =>
      _NotifiesPageState(); // Crea el estado de la página de notificaciones.
}

class _NotifiesPageState extends State<NotifiesPage> {
  final List<String> notifications = [
    // Lista de notificaciones.
    '45m ago - New Menu: We added a new menu for vegans.',
    '45m ago - Extended Service: VEGAN (Extended service only today.)',
    '1h ago - Know Our New Service',
    '1d ago - We have a new wrapping service that might interest you.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Notificaciones'), // Título de la barra de aplicación.
      ),
      body: ListView.builder(
        // Construye una lista de elementos de manera eficiente.
        itemCount: notifications.length, // Número total de notificaciones.
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            // Crea un desplazamiento vertical para los elementos.
            child: Column(
              children: [
                Dismissible(
                  // Widget que permite deslizar para eliminar un elemento.
                  key: Key(notifications[
                      index]), // Clave única para el elemento Dismissible.
                  onDismissed: (DismissDirection dir) {
                    // Acción cuando se desliza para eliminar.
                    setState(() {
                      notifications.removeAt(
                          index); // Elimina la notificación de la lista.
                    });
                  },
                  background: Container(
                    // Fondo que se muestra al deslizar para eliminar.
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red, // Color de fondo rojo.
                    child: const Icon(
                      Icons.delete, // Ícono de eliminación.
                      color: Colors.white, // Color del ícono.
                    ),
                  ),
                  child: Card(
                    // Tarjeta que contiene la notificación.
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(
                          Icons.notifications), // Ícono de notificaciones.
                      title: Text(
                        notifications[index], // Texto de la notificación.
                        style:
                            const TextStyle(fontSize: 16), // Estilo del texto.
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
