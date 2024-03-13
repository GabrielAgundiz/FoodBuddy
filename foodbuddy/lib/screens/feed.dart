import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodbuddy/screens/catscreen.dart';
import 'package:foodbuddy/widgets/antojo.dart';
import 'package:foodbuddy/widgets/categorias.dart';
import 'package:foodbuddy/widgets/homeappbar.dart';

class FeedPage extends StatelessWidget {
  String currentCat = "Todos";
  final List<String> categories = [
    'Todos',
    'Vegano',
    'Vegetariano',
    'Diabetico',
    'Fitness',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Categorias",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Categorias(categories: categories, currentCat: currentCat),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Para tu antojo",
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
                              builder: (context) => const CategoryScreen()),
                        );
                      },
                      child: Text(
                        "Ver todos",
                        style: TextStyle(color: Colors.green[400]),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Antojo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
