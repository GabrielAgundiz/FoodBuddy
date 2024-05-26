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
  static List previousSearchs = []; // Lista para almacenar búsquedas anteriores

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
            'Busqueda',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), // Título de la barra de navegación
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Padding(
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
                              searchController == null ? null : Icons.cancel,
                          onTapSuffixIcon: () {
                            searchController.clear();
                            setState(() {
                              showGridView =
                                  false; // Ocultar el GridView al hacer clic en el campo de búsqueda
                            });
                          },
                          onChanged: (pure) {
                            setState(() {});
                          },
                          onEditingComplete: () async {
                            SearchPage.previousSearchs
                                .add(searchController.text);
                            List<Food> searchResults =
                                await buscarEnBaseDeDatos(
                                    searchController.text);
                            setState(() {
                              this.searchResults = searchResults;
                              showGridView = true;
                            }); // Actualiza el estado para mostrar los resultados
                          },
                        ),
                      ),
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
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Busquedas Recomendadas",
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
                          searchSuggestionsTiem("Vegetarianos"),
                          searchSuggestionsTiem("Veganos"),
                          searchSuggestionsTiem("Diabeticos"),
                          searchSuggestionsTiem("Antojos"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previousSearchsItem(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          // Al hacer clic en el elemento, navegar a DescScreen con el elemento de búsqueda seleccionado
          String selectedSearch = SearchPage.previousSearchs[index];
          Food selectedFood = searchResults.firstWhere(
              (food) => food.name == selectedSearch,
              orElse: () => Food('', '', '', '', '', 0, 0, 0, 0,
                  '')); // Podrías usar una instancia de Food vacía si el elemento no se encuentra
          navigateToDescScreen(selectedFood);
        },
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            SearchPage.previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.restore,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                SearchPage.previousSearchs[index],
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

  Widget searchSuggestionsTiem(String text) {
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
          case "Diabeticos":
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
