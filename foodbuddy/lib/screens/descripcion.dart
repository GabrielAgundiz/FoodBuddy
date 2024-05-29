import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

import '../state/states.dart';

const kprimaryColor = Color(0xFF5DB075);

class DescScreen extends StatefulWidget {
  final Food food;
  const DescScreen({super.key, required this.food});

  @override
  State<DescScreen> createState() => _DescripcionState();
}

class _DescripcionState extends State<DescScreen> {
  late bool isLiked;
// Inicialización del plugin de notificaciones locales
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotification();
  }

  void _launchURL(String urlFood) async {
    final url = urlFood;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {
                    _launchURL(widget.food.link_food);
                    _scheduleNotification();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Ver en Delivery App"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    if (favoriteState.foodIds.contains(widget.food.id)) {
                      _removeFromFavorite(context, widget.food.id);
                    } else {
                      _addToFavorite(context, widget.food.id);
                    }
                  },
                  style: IconButton.styleFrom(
                      shape: CircleBorder(
                          side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2,
                  ))),
                  icon: Icon(
                      favoriteState.foodIds.contains(widget.food.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteState.foodIds.contains(widget.food.id)
                          ? Colors.red
                          : Colors.black,
                      size: 24),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            widget.food.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.food.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.food.cal} Cal",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          "  •  ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Icons.schedule,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.food.time} Min",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade500,
                          size: 22,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.food.rate}/5",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${widget.food.reviews} Reviews)",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Ingredientes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.food.ingredients
                          .split(',')
                          .map(
                            (ingredient) => Text(
                              '• ${ingredient.trim()}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      );
    });
  }

  void _addToFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(AddFoodToFavorite(foodId));
    setState(() {
      isLiked = true;
    });
    _scheduleNotification();
  }

  void _removeFromFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(RemoveFoodFromFavorite(foodId));
    setState(() {
      isLiked = false;
    });
  }

  void _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'Notificación de favorito',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'appicon',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    final tz.TZDateTime scheduledNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));

    // Agregar un mensaje de log
    print(
        'Programando notificación para ${scheduledNotificationDateTime.toLocal()}');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      11,
      'Nuevo favorito',
      'Has añadido ${widget.food.name} a tus favoritos',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
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
/*void _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'Notificación de favorito',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'appicon',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Calcula la fecha y hora en la que se debe mostrar la notificación (20 segundos después)
    final tz.TZDateTime scheduledNotificationDateTime =
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Nuevo favorito',
      'Has añadido ${widget.food.name} a tus favoritos',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }*/
}
