import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Que estas buscando hoy?",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        Spacer(),
       // IconButton(
      //      onPressed: () {},
      //      style: IconButton.styleFrom(
     //         shape: RoundedRectangleBorder(
     //           borderRadius: BorderRadius.circular(15),
     //         ),
    //          backgroundColor: Colors.white,
    //          fixedSize: const Size(55, 55),
   //           shadowColor: Colors.grey,
   //         ),
   //         icon: const Icon(Icons.notifications)),
      ],
    );
  }
}
