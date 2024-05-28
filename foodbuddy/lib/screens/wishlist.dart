import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/widgets/food_card.dart';

import '../state/states.dart'; // Importa el widget Platillo

// Página de los alimentos guardados como favoritos
class SavesPage extends StatelessWidget {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos', // Título de la barra de aplicación
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Food>>(
                  future: _foodService.getFoods(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Food> foods = snapshot.data!;
                      if (favoriteState.foodIds.isEmpty) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                              child: Text(
                            "Aún no tienes favoritos",
                            style: TextStyle(color: Colors.grey.shade500),
                          )),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              children: favoriteState.foodIds
                                  .map((foodId) => Platillo(
                                        food: foods.firstWhere(
                                            (food) => food.id == foodId),
                                      ))
                                  .toList(),
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
