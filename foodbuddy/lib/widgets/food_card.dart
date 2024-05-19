import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/state/states.dart';

// Este widget representa un platillo individual en la lista de platillos.
class Platillo extends StatefulWidget {
  final Food food;

  // Constructor para el widget Platillo que recibe un objeto de tipo Food.
  const Platillo({Key? key, required this.food}) : super(key: key);

  @override
  _PlatilloState createState() => _PlatilloState();
}

class _PlatilloState extends State<Platillo> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    // GestureDetector detecta gestos como toques.
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
      //var action = () => _addToFavorite(context, widget.food.id);
      return GestureDetector(
        // Al tocar el platillo, se navega a la pantalla de descripción.
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescScreen(food: widget.food),
          ),
        ),
        child: Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Columna que contiene la imagen y la información del platillo.
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contenedor para la imagen del platillo.
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 8.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.food.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Nombre del platillo.
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // Información de calorías y tiempo de preparación.
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.cal} Cal",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          " • ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Icons.schedule,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.food.time} Min",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // Calificación y número de reseñas.
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade500, size: 18),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.food.rate}/5",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${widget.food.reviews} Reviews)",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
                // Botón de "Me gusta" en la esquina superior derecha.
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      //saveFavorite();
                      if (favoriteState.foodIds.contains(widget.food.id)) {
                        _removeFromFavorite(context, widget.food.id);
                      } else {
                        _addToFavorite(context, widget.food.id);
                      }
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(25, 25),
                    ),
                    iconSize: 20,
                    // El icono cambia según si el platillo está marcado como "me gusta".
                    icon: favoriteState.foodIds.contains(widget.food.id)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),
          ),
        ),
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
