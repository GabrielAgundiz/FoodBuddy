import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/catscreen.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/screens/diabeticscreen.dart';
import 'package:foodbuddy/screens/veganscreen.dart';
import 'package:foodbuddy/screens/vegetarianscreen.dart';
import 'package:foodbuddy/service/food_service.dart';
import 'package:foodbuddy/widgets/ctfl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda
  FoodService _foodService = FoodService(); // Instancia de tu servicio
  List<Food> searchResults =
      []; // Lista para almacenar los resultados de la búsqueda
  bool showGridView =
      true; // Variable para controlar la visibilidad del GridView
  bool showRecommendations =
      true; // Variable para controlar la visibilidad de las recomendaciones
  List<String> previousSearches =
      []; // Lista para almacenar búsquedas anteriores

  @override
  void initState() {
    super.initState();
    _loadSearchResults('');
  }

  Future<void> _loadSearchResults(String searchTerm) async {
    List<Food> foods =
        await _foodService.getFoods(); // Obtener la lista de alimentos
    setState(() {
      searchResults = foods
          .where((food) =>
              food.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList(); // Aplicar filtro
    });
  }

  Future<List<Food>> buscarEnBaseDeDatos(String searchTerm) async {
    await _loadSearchResults(searchTerm);
    return searchResults;
  }

  void navigateToDescScreen(Food food) {
    // Navegar a DescScreen con el objeto Food seleccionado
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescScreen(food: food),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Búsqueda',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), // Título de la barra de navegación
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: CostomTextFormFild(
                        // Widget personalizado para el campo de texto de búsqueda
                        hint: "Buscar",
                        prefixIcon: Icons.search_rounded,
                        controller: searchController,
                        filled: false,
                        suffixIcon:
                            searchController.text.isEmpty ? null : Icons.cancel,
                        onTapSuffixIcon: () {
                          searchController.clear();
                          setState(() {
                            showGridView =
                                false; // Ocultar el GridView al hacer clic en el campo de búsqueda
                            showRecommendations =
                                true; // Mostrar recomendaciones
                          });
                        },
                        onChanged: (text) {
                          setState(() {
                            // Actualizar resultados en tiempo real mientras se escribe
                            buscarEnBaseDeDatos(text);
                          });
                        },
                        onEditingComplete: () async {
                          previousSearches.add(searchController.text);
                          List<Food> searchResults =
                              await buscarEnBaseDeDatos(searchController.text);
                          setState(() {
                            this.searchResults = searchResults;
                            showGridView = true;
                            showRecommendations =
                                false; // Ocultar recomendaciones al realizar una búsqueda
                          }); // Actualiza el estado para mostrar los resultados
                        },
                      ),
                    ),
                    if (!showRecommendations)
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons
                              .tune, // Icono para ajustar los filtros de búsqueda
                        ),
                      ),
                  ],
                ),
              ),
              if (showRecommendations)
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Búsquedas Recomendadas",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis
                            .horizontal, // Establecemos la dirección del scroll en horizontal
                        child: Row(
                          children: [
                            searchSuggestionsItem("Vegetarianos"),
                            searchSuggestionsItem("Veganos"),
                            searchSuggestionsItem("Diabéticos"),
                            searchSuggestionsItem("Antojos"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: showGridView
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final item = searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              navigateToDescScreen(item);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(item.image),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5,
                                                ),
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.6,
                                                ),
                                                child: Text(
                                                  "${item.restaurant} - ${item.category}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_fire_department,
                                            size: 20,
                                            color: Colors.grey.shade400,
                                          ),
                                          Text(
                                            "${item.cal} Cal",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.15,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Introduce un término de búsqueda"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previousSearchesItem(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          // Al hacer clic en el elemento, navegar a DescScreen con el elemento de búsqueda seleccionado
          String selectedSearch = previousSearches[index];
          Food selectedFood = searchResults.firstWhere(
              (food) => food.name == selectedSearch,
              orElse: () => Food('', '', '', '', '', 0, 0, 0, 0, '', ''));
          navigateToDescScreen(selectedFood);
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearches.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.restore,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                previousSearches[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchSuggestionsItem(String text) {
    return GestureDetector(
      onTap: () {
        // Aquí debes manejar la navegación a la pantalla correspondiente
        switch (text) {
          case "Vegetarianos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VegetarianScreen()),
            );
            break;
          case "Veganos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VeganScreen()),
            );
            break;
          case "Diabéticos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DiabeticScreen()),
            );
            break;
          case "Antojos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
            break;
          default:
            // Por si acaso, no debería entrar aquí
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.green),
        ),
      ),
    );
  }
}
