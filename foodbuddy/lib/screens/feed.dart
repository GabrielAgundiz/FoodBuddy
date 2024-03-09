import 'package:flutter/material.dart';
class FeedPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la página de inicio',
          style: TextStyle(fontSize: 24),
        ),
      ),

      );
    
  }
}