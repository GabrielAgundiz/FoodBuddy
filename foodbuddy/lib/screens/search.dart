import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Busqueda', style: TextStyle(fontWeight: FontWeight.bold),), // Título de la barra de navegación
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
                            searchController
                                .clear(); // Limpia el campo de búsqueda al hacer clic en el icono de cancelar
                          },
                          onChanged: (pure) {
                            setState(() {});
                          },
                          onEditingComplete: () {
                            SearchPage.previousSearchs.add(searchController
                                .text); // Agrega la búsqueda actual a la lista de búsquedas anteriores
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomePage())); // Navega a la página de inicio con los resultados de la búsqueda
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
              Container(
                color: Colors.white,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: SearchPage.previousSearchs.length,
                    itemBuilder: (context, index) => previousSearchsItem(
                        index)), // Construye los elementos de la lista de búsquedas anteriores
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
                        searchSuggestionsTiem(
                            "Sushi"), // Elemento de sugerencia de búsqueda
                        searchSuggestionsTiem(
                            "Hamburguesas"), // Elemento de sugerencia de búsqueda
                        searchSuggestionsTiem(
                            "Pasta"), // Elemento de sugerencia de búsqueda
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

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap:
            () {}, // Acción al hacer clic en el elemento de la lista (no implementada aquí)
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            SearchPage.previousSearchs.removeAt(
                index); // Elimina la búsqueda anterior de la lista al deslizar
          },
          child: Row(
            children: [
              const Icon(
                Icons
                    .restore, // Icono para mostrar que es una búsqueda anterior
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                SearchPage.previousSearchs[
                    index], // Muestra el texto de la búsqueda anterior
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Icon(
                Icons
                    .call_made_outlined, // Icono para mostrar la dirección de la acción (no implementado aquí)
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              30)), // Estilo del contenedor que contiene la sugerencia de búsqueda
      child: Text(
        text, // Texto de la sugerencia de búsqueda
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color:
                Colors.green), // Estilo del texto de la sugerencia de búsqueda
      ),
    );
  }
}
