import 'package:flutter/material.dart';
class SavesPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Guardados'),
      ),
      body: const Center(
        child: SingleChildScrollView(
        child: Text(
          'Bienvenido a la página de Guardados',
          style: TextStyle(fontSize: 24),
        ),
      ),
      ),
      );
    
  }
}