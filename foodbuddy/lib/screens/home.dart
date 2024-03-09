import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text(
          'Bienvenido a la página de inicio',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Negocios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Educación',
          ),
        ],
       // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
       // onTap: _onItemTapped,
      ),
    );
  }
}