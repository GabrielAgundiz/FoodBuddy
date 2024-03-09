import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a busqueda',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }
}