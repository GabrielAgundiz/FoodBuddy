import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Text(
            'Bienvenido a la configuracion',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      
    );
  }
}
