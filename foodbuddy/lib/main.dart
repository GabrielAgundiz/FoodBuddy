import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/screens/login.dart';
import 'package:foodbuddy/state/states.dart';
import 'package:timezone/data/latest.dart' as tz;

// Función principal que se ejecuta cuando se inicia la aplicación
Future<void> main() async {
  // Asegura que el binding de WidgetsFlutter esté inicializado antes de hacer cualquier cosa más
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa la aplicación de Firebase
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  // Ejecuta la aplicación MyApp
  runApp(
    BlocProvider(
      create: (_) => FavoriteBloc(),
      child: MyApp(),
    ),
  );
}

// Clase que extiende StatelessWidget y representa la aplicación completa
class MyApp extends StatelessWidget {
  // Método build que devuelve el árbol de widgets que representa la aplicación
  @override
  Widget build(BuildContext context) => MaterialApp(
        // Oculta la etiqueta de depuración en la esquina superior derecha
        debugShowCheckedModeBanner: false,
        // Establece el título de la aplicación
        title: 'FoodBuddy',
        // Establece el tema de la aplicación
        theme: ThemeData(
          // Establece el color principal de la aplicación
          primarySwatch: Colors.green,
          // Establece el color de fondo de la pantalla de la aplicación
          scaffoldBackgroundColor: Colors.white,
          // Establece la densidad visual de la aplicación
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Establece la página de inicio de sesión como la pantalla de inicio de la aplicación
        home: LoginPage(),
      );
}
