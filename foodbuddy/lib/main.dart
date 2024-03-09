import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/login.dart'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodBuddy',
      home: LoginPage(),
       
    );
  }
}