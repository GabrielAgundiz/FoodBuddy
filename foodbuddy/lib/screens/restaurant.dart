import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/screens/restdesc.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/state/states.dart'; // Importa el servicio FoodService

// Widget RestaurantPage que muestra una lista de restaurantes.
class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key});

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final FoodService _foodService = FoodService(); // Instancia de tu servicio
  List<Food> foods = []; // Lista para almacenar los restaurantes

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    List<Food> fetchedFoods = await _foodService
        .getFoods(); // Obtener la lista de restaurantes desde Firebase
    setState(() {
      foods = fetchedFoods; // Asignar los restaurantes a la lista
    });
  }

  late bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurantes', // Título de la barra de aplicación
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, favoriteState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SingleChildScrollView permite desplazar la fila de restaurantes horizontalmente.
            SingleChildScrollView(
              scrollDirection: Axis.vertical, // Desplazamiento horizontal.
              child: Container(
                 width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    foods
                        .length, // Usamos la lista de restaurantes obtenida desde Firebase
                    (index) => GestureDetector(
                      // Al tocar un alimento, se navega a la pantalla de descripción del alimento.
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestDescScreen(),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right:
                                10, left: 10), // Margen derecho para separar los restaurantes.
                        width: MediaQuery.of(context).size.width / 2.3, // Ancho del contenedor que contiene el alimento.
                        child: Stack(
                          children: [
                            // Columna que contiene la imagen y la información del alimento.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Contenedor para la imagen del alimento.
                                Container(
                                  width: double.infinity,
                                  height:
                                      130, // Altura fija para la imagen del alimento.
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        15), // Bordes redondeados de la imagen.
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        foods[index]
                                            .image, // URL de la imagen del alimento.
                                      ),
                                      fit: BoxFit
                                          .fill, // Ajuste de la imagen para llenar el contenedor.
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Nombre del alimento.
                                Text(
                                  foods[index].name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Información nutricional del alimento (calorías y tiempo de preparación).
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
                            // Botón de "Me gusta" en la esquina superior derecha.
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
                                  backgroundColor:
                                      Colors.white, // Color de fondo del botón.
                                  fixedSize:
                                      const Size(25, 25), // Tamaño fijo del botón.
                                ),
                                iconSize: 20, // Tamaño del icono del botón.
                                icon: Icon(
                                  favoriteState.foodIds.contains(foods[index].id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteState.foodIds
                                          .contains(foods[index].id)
                                      ? Colors.red
                                      : null,
                                ), // Icono del botón.
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
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
