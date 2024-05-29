import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/state/states.dart';

// Este widget representa un platillo individual en la lista de platillos.
class Platillo extends StatefulWidget {
  final Food food;

  const Platillo({Key? key, required this.food}) : super(key: key);

  @override
  _PlatilloState createState() => _PlatilloState();
}

class _PlatilloState extends State<Platillo> {
  bool isLiked = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, favoriteState) {
        return GestureDetector(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 8.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(widget.food.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.cal} Cal",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          " • ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Icons.schedule,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.time} Min",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.yellow.shade500, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.food.rate}/5",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${widget.food.reviews} Reviews)",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      if (favoriteState.foodIds.contains(widget.food.id)) {
                        _removeFromFavorite(context, widget.food.id);
                      } else {
                        _addToFavorite(context, widget.food.id);
                      }
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(25, 25),
                    ),
                    iconSize: 20,
                    icon: favoriteState.foodIds.contains(widget.food.id)
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(AddFoodToFavorite(foodId));
    setState(() {
      isLiked = true;
    });
    _scheduleNotificationFav();
  }

  void _removeFromFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(RemoveFoodFromFavorite(foodId));
    setState(() {
      isLiked = false;
    });
  }

  _scheduleNotificationFav() async {
    // Espera 5 segundos antes de mostrar la notificación
    Timer(Duration(seconds: 4), () {
      // Detalles específicos de la notificación para Android
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        "channelId", // ID del canal de notificación
        "channelName", // Nombre del canal de notificación
        "channelDescription", // Descripción del canal
        importance: Importance.max, // Importancia máxima para la notificación
        priority: Priority.high, // Alta prioridad para la notificación
        icon: 'appicon', // Nombre del ícono de la tarea
      );

      // Detalles específicos de la notificación para todas las plataformas
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Muestra la notificación con los detalles configurados
      flutterLocalNotificationsPlugin.show(
        0, // ID de la notificación
        "Regresa a tu producto", // Título de la notificación
        "Recientemente has añadido ${widget.food.name} a tus favoritos, regresa a completar tu pedido! ", // Cuerpo de la notificación
        platformChannelSpecifics, // Detalles específicos de la plataforma
      );
    });
  }

// Inicializa las configuraciones de notificaciones
  void _initializeNotification() async {
    // Configuraciones de inicialización específicas para Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'appicon'); // Nombre correcto del ícono de la tarea

    // Configuraciones de inicialización para todas las plataformas
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Inicializa el plugin de notificaciones con las configuraciones especificadas
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
