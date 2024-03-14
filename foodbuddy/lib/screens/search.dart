import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/descripcion.dart';
import 'package:foodbuddy/screens/diabeticscreen.dart';
import 'package:foodbuddy/screens/veganscreen.dart';
import 'package:foodbuddy/screens/vegetarianscreen.dart';
import 'package:foodbuddy/widgets/ctfl.dart'; // Importa el widget personalizado CostomTextFormFild

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static List previousSearchs = []; // Lista para almacenar búsquedas anteriores

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda
  Future<List<Food>> buscarEnBaseDeDatos(String searchTerm) async {
    // Simulación de búsqueda en una base de datos
    await Future.delayed(const Duration(
        seconds:
            1)); // Simulación de retraso de 1 segundo para imitar una búsqueda en una base de datos remota

    // Filtro de alimentos que contienen el término de búsqueda en su nombre
    List<Food> searchResults = foods
        .where((food) =>
            food.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

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
                            setState(
                                () {}); // Actualiza el estado para mostrar los resultados
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
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: SearchPage.previousSearchs.length,
                  itemBuilder: (context, index) =>
                      previousSearchsItem(index, context),
                ),
              ),
              const SizedBox(
                height: 8,
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
                    Row(
                      children: [
                        Row(
                          children: [
                            searchSuggestionsTiem("Vegetarianos"),
                            searchSuggestionsTiem("Veganos"),
                          ],
                        ),
                        Row(
                          children: [
                            searchSuggestionsTiem("Diabeticos"),
                          ],
                        )
                      ],
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
          navigateToDescScreen(foods.firstWhere(
              (food) => food.name == SearchPage.previousSearchs[index]));
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
              MaterialPageRoute(builder: (context) => VegetarianScreen()),
            );
            break;
          case "Veganos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VeganScreen()),
            );
            break;
          case "Diabeticos":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiabeticScreen()),
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
