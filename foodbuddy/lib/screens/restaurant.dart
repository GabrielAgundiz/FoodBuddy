import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/restaurants.dart';
import 'package:foodbuddy/screens/restdesc.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/service/restaurant_service.dart';
import 'package:foodbuddy/state/states.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key});

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final FoodService _foodService = FoodService();
  final RestaurantService _restaurantService = RestaurantService();
  //List<Food> foods = [];
  List<Restaurants> restaurants = [];

  @override
  void initState() {
    super.initState();
    //_loadFoods();
    _loadRestaurants();
  }

  /*Future<void> _loadFoods() async {
    List<Food> fetchedFoods = await _foodService.getFoods();
    setState(() {
      foods = fetchedFoods;
    });
  }*/
  Future<void> _loadRestaurants() async {
    List<Restaurants> restaurantsObtenidos =
        await _restaurantService.getRestaurants();
    setState(() {
      restaurants = restaurantsObtenidos;
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
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestDescScreen(restaurants[index], index),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 8.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      restaurants[index].image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                restaurants[index].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      restaurants[index].address,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /*Positioned(
                            top: 1,
                            right: 1,
                            child: IconButton(
                              onPressed: () {
                                if (favoriteState.foodIds
                                    .contains(restaurants[index].id)) {
                                  _removeFromFavorite(context, restaurants[index].id);
                                } else {
                                  _addToFavorite(context, restaurants[index].id);
                                }
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(25, 25),
                              ),
                              iconSize: 20,
                              icon: Icon(
                                favoriteState.foodIds.contains(restaurants[index].id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteState.foodIds
                                        .contains(restaurants[index].id)
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  itemCount: restaurants.length,
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
