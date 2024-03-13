import 'package:flutter/material.dart';

const kprimaryColor = Color(0xFF5DB075);

class Categorias extends StatelessWidget {
  
  const Categorias({
    super.key,
    required this.categories,
    required this.currentCat,
  });

  final List<String> categories;
  final String currentCat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          height: 50, // set the desired height here
          child: Row(
            children: List.generate(
              categories.length,
              (index) => Container(
                decoration: BoxDecoration(
                  color: currentCat == categories[index]
                      ? kprimaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: currentCat == categories[index]
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
