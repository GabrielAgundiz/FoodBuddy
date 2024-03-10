import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busqueda'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Text(
            'Bienvenido a busqueda',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
