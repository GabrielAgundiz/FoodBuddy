import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/screens/restdesc.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/state/states.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key});

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final FoodService _foodService = FoodService();
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    List<Food> fetchedFoods = await _foodService.getFoods();
    setState(() {
      foods = fetchedFoods;
    });
  }

  late bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurantes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, favoriteState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestDescScreen(),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 8.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      foods[index].image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                foods[index].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "Direccion #123",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: IconButton(
                              onPressed: () {
                                if (favoriteState.foodIds
                                    .contains(foods[index].id)) {
                                  _removeFromFavorite(context, foods[index].id);
                                } else {
                                  _addToFavorite(context, foods[index].id);
                                }
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(25, 25),
                              ),
                              iconSize: 20,
                              icon: Icon(
                                favoriteState.foodIds.contains(foods[index].id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteState.foodIds
                                        .contains(foods[index].id)
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: foods.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _addToFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(AddFoodToFavorite(foodId));
    setState(() {
      isLiked = true;
    });
  }

  void _removeFromFavorite(BuildContext context, String foodId) {
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(RemoveFoodFromFavorite(foodId));
    setState(() {
      isLiked = false;
    });
  }
}
