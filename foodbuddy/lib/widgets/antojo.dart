import 'package:flutter/material.dart';
import 'package:foodbuddy/models/food.dart';
import 'package:foodbuddy/screens/catscreen.dart';
import 'package:foodbuddy/screens/descripcion.dart';

class Antojo extends StatelessWidget {
  const Antojo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(
            foods.length,
            (index) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescScreen(food: foods[index]),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 200,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                foods[index].image,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              size: 18,
                              color: Colors.grey,
                            ),
                            Text(
                              "${foods[index].cal} Cal",
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
                              "${foods[index].time} Min",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(25, 25),
                        ),
                        iconSize: 20,
                        icon: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
