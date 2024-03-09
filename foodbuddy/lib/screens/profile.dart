import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a tu perfil',
          style: TextStyle(fontSize: 24),
        ),
      ),
    
    );
  }
}