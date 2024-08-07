import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/catscreen.dart';
import 'package:foodbuddy/screens/diabeticscreen.dart';
import 'package:foodbuddy/screens/ketoscreen.dart';
import 'package:foodbuddy/screens/veganscreen.dart';
import 'package:foodbuddy/screens/vegetarianscreen.dart';
import 'package:foodbuddy/widgets/antojo.dart';
import 'package:foodbuddy/widgets/categorias.dart';
import 'package:foodbuddy/widgets/diabetico.dart';
import 'package:foodbuddy/widgets/homeappbar.dart';
import 'package:foodbuddy/widgets/keto.dart';
import 'package:foodbuddy/widgets/veganos.dart';
import 'package:foodbuddy/widgets/vegetarianos.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Página de alimentación (Feed)
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String currentCat = "Todos"; // Categoría actualmente seleccionada
  final List<String> categories = [
    // Lista de categorías disponibles
    'Todos',
    'Vegano',
    'Vegetariano',
    'Diabetico',
    'Keto',
  ];

  void updateCurrentCategory(String category) {
    setState(() {
      currentCat = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Título de la barra de aplicación
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(), // Barra de aplicación personalizada (widget HomeAppbar)
                const SizedBox(
                  height: 20,
                ),
                const FeedPublicityCarousel(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Categorias", // Título de la sección de categorías
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Categorias(
                  categories: categories,
                  currentCat: currentCat,
                  updateCurrentCategory: updateCurrentCategory,
                ), // Widget para mostrar las categorías disponibles
                const SizedBox(
                  height: 20,
                ),
                if (currentCat == 'Todos') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Para tu antojo", // Título de la sección "Para tu antojo"
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CategoryScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                          );
                        },
                        child: Text(
                          "Ver todos", // Etiqueta del botón "Ver todos"
                          style: TextStyle(
                              color: Colors
                                  .green[400]), // Color del texto del botón
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Antojo(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (currentCat == 'Todos' || currentCat == 'Vegano') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Para veganos", // Título de la sección Veganos
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VeganScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                          );
                        },
                        child: Text(
                          "Ver todos", // Etiqueta del botón "Ver todos"
                          style: TextStyle(
                              color: Colors
                                  .green[400]), // Color del texto del botón
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Veganos(), // Widget para mostrar alimentos según los veganos
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (currentCat == 'Todos' || currentCat == 'Vegetariano') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Para vegetarianos", // Título de la sección Vegetarianos
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VegetarianScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                          );
                        },
                        child: Text(
                          "Ver todos", // Etiqueta del botón "Ver todos"
                          style: TextStyle(
                              color: Colors
                                  .green[400]), // Color del texto del botón
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Vegetarianos(), // Widget para mostrar alimentos según los vegetarianos
                  const SizedBox(
                    height: 20,
                  ),
                ],
                const SizedBox(
                    height: 20,
                  ),
                GestureDetector(
                  onTap: () async {
                    await launchUrlString('https://www.thelittleblogofvegan.com/');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://i0.wp.com/www.thelittleblogofvegan.com/wp-content/uploads/2022/01/FOOTER-scaled.jpg?fit=2560%2C584&ssl=1',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                if (currentCat == 'Todos' || currentCat == 'Diabetico') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Para diabeticos", // Título de la sección Diabeticos
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DiabeticScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                          );
                        },
                        child: Text(
                          "Ver todos", // Etiqueta del botón "Ver todos"
                          style: TextStyle(
                              color: Colors
                                  .green[400]), // Color del texto del botón
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Diabeticos(), // Widget para mostrar alimentos según los diabeticos
                  const SizedBox(
                    height: 20,
                  ),
                ],
                if (currentCat == 'Todos' || currentCat == 'Keto') ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Menu Keto", // Título de la sección Menu Keto
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KetoScreen()), // Navega a la pantalla de categoría cuando se presiona el botón "Ver todos"
                          );
                        },
                        child: Text(
                          "Ver todos", // Etiqueta del botón "Ver todos"
                          style: TextStyle(
                              color: Colors
                                  .green[400]), // Color del texto del botón
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Keto(), // Widget para mostrar alimentos según los diabeticos
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedPublicityCarousel extends StatelessWidget {
  const FeedPublicityCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://c.ndtvimg.com/2021-06/tau0bv3o_burger-king_625x300_24_June_21.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://explainvisually.co/wp-content/uploads/2020/12/weganski-burger-impossible-meat-marketing.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://www.bizadmark.com/wp-content/uploads/2021/08/vegan-ad.webp',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://www.bizadmark.com/wp-content/uploads/2021/09/plant-based-advertising.jpeg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 190,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
