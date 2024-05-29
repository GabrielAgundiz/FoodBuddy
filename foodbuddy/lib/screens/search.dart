import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
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
      false; // Variable para controlar la visibilidad del GridView
  bool showRecommendations =
      true; // Variable para controlar la visibilidad de las recomendaciones
  bool showFilterOptions =
      false; // Variable para controlar la visibilidad de las opciones de filtro
  bool isVegan = false; // Variable para el estado del checkbox
  bool isVegetarian = false;
  bool isDiabetic = false;
  bool isKeto = false;
  bool isAll = true;
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
              food.name.toLowerCase().contains(searchTerm.toLowerCase()) &&
              _applyCategoryFilter(food))
          .toList(); // Aplicar filtro
    });
  }

  bool _applyCategoryFilter(Food food) {
    if (isAll) {
      return true;
    }
    if (isVegan && food.category.toLowerCase() == 'vegano') {
      return true;
    }
    if (isVegetarian && food.category.toLowerCase() == 'vegetariano') {
      return true;
    }
    if (isDiabetic && food.category.toLowerCase() == 'diabetico') {
      return true;
    }
    if (isKeto && food.category.toLowerCase() == 'keto') {
      return true;
    }
    return false;
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CostomTextFormFild(
                            // Widget personalizado para el campo de texto de búsqueda
                            hint: "Buscar",
                            prefixIcon: Icons.search_rounded,
                            controller: searchController,
                            filled: false,
                            suffixIcon: searchController.text.isEmpty
                                ? null
                                : Icons.cancel,
                            onTapSuffixIcon: () {
                              searchController.clear();
                              setState(() {
                                showGridView =
                                    false; // Ocultar el GridView al hacer clic en el campo de búsqueda
                                showRecommendations =
                                    true; // Mostrar recomendaciones
                                showFilterOptions =
                                    false; // Ocultar los filtros de búsqueda
                              });
                            },
                            onChanged: (text) {
                              setState(() {
                                // Actualizar resultados en tiempo real mientras se escribe
                                buscarEnBaseDeDatos(text);
                                if (text.isEmpty) {
                                  showFilterOptions =
                                      false; // Ocultar los filtros de búsqueda si el campo está vacío
                                }
                              });
                            },
                            onEditingComplete: () async {
                              previousSearches.add(searchController.text);
                              List<Food> searchResults =
                                  await buscarEnBaseDeDatos(
                                      searchController.text);
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
                            onPressed: () {
                              setState(() {
                                showFilterOptions =
                                    !showFilterOptions; // Alternar la visibilidad de las opciones de filtro
                              });
                            },
                            icon: const Icon(
                              Icons
                                  .tune, // Icono para ajustar los filtros de búsqueda
                            ),
                          ),
                      ],
                    ),
                    if (showFilterOptions)
                      Row(
                        children: [
                          const Text(
                            "Categorias: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAll = !isAll;
                                        _loadSearchResults(
                                            searchController.text);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isAll,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isAll = value ?? false;
                                              _loadSearchResults(
                                                  searchController.text);
                                            });
                                          },
                                        ),
                                        const Text("Todos"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVegan = !isVegan;
                                        _loadSearchResults(
                                            searchController.text);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isVegan,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isVegan = value ?? false;
                                              _loadSearchResults(
                                                  searchController.text);
                                            });
                                          },
                                        ),
                                        const Text("Vegano"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVegetarian = !isVegetarian;
                                        _loadSearchResults(
                                            searchController.text);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isVegetarian,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isVegetarian = value ?? false;
                                              _loadSearchResults(
                                                  searchController.text);
                                            });
                                          },
                                        ),
                                        const Text("Vegetariano"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDiabetic = !isDiabetic;
                                        _loadSearchResults(
                                            searchController.text);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isDiabetic,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isDiabetic = value ?? false;
                                              _loadSearchResults(
                                                  searchController.text);
                                            });
                                          },
                                        ),
                                        const Text("Diabetico"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isKeto = !isKeto;
                                        _loadSearchResults(
                                            searchController.text);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isKeto,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isKeto = value ?? false;
                                              _loadSearchResults(
                                                  searchController.text);
                                            });
                                          },
                                        ),
                                        const Text("Keto"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                        "Búsquedas Recientes",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SingleChildScrollView(
                        scrollDirection:
                            Axis.horizontal, // Cambia la dirección del scroll
                        child: Row(
                          children: previousSearches.map((search) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchController.text = search;
                                  isAll = true; // Establecer isAll en true
                                  buscarEnBaseDeDatos(
                                      search); // Realiza la búsqueda al hacer clic en la recomendación
                                  showGridView =
                                      true; // Muestra los resultados de búsqueda en el GridView
                                  showRecommendations =
                                      false; // Oculta las recomendaciones
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  search,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
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
                                                          0.45,
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
                                                          0.45,
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
}

class PlatilloWidget extends StatelessWidget {
  final Food food;

  PlatilloWidget({required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(food.image),
          Text(food.name),
          Text(food.category),
        ],
      ),
    );
  }
}
