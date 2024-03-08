import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/login.dart'; 
import 'package:google_fonts/google_fonts.dart'; 

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      home: LoginPage(),
       
    );
  }
}