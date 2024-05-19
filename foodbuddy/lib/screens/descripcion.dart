import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/food.dart';
import '../state/states.dart';

const kprimaryColor = Color(0xFF5DB075);

class DescScreen extends StatefulWidget {
  final Food food;
  const DescScreen({super.key, required this.food});

  @override
  State<DescScreen> createState() => _DescripcionState();
}

class _DescripcionState extends State<DescScreen> {
  late bool isLiked;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Ver en Delivery App"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    if (favoriteState.foodIds.contains(widget.food.id)) {
                      _removeFromFavorite(context, widget.food.id);
                    } else {
                      _addToFavorite(context, widget.food.id);
                    }
                  }, 
                  style: IconButton.styleFrom(
                      shape: CircleBorder(
                          side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2,
                  ))),
                  icon: Icon(
                      favoriteState.foodIds.contains(widget.food.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteState.foodIds.contains(widget.food.id)
                          ? Colors.red
                          : Colors.black,
                      size: 24),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            widget.food.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.food.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.cal} Cal",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          "  •  ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Icons.schedule,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.time} Min",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade500, size: 22),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.food.rate}/5",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${widget.food.reviews} Reviews)",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ingredientes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.food.ingredients
                                  .split(',')
                                  .map(
                                    (ingredient) => Text(
                                      '• ${ingredient.trim()}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700),
                                          softWrap: true,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      );
    });
  }

  void _addToFavorite(BuildContext context, String foodId) {
    //le paso el context para obtener el bookshelfBloc
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(AddFoodToFavorite(foodId));
    setState(() {
      isLiked = true;
    });
  }

  void _removeFromFavorite(BuildContext context, String foodId) {
    //le paso el context para obtener el bookshelfBloc
    var favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(RemoveFoodFromFavorite(foodId));
    setState(() {
      isLiked = false;
    });
  }
}
