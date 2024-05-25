import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodbuddy/models/food.dart';

class RestaurantService {
  final restaurantRef =
      FirebaseFirestore.instance.collection('restaurant').withConverter(
            fromFirestore: (snapshot, _) =>
                Food.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (food, _) => food.toJson(),
          );

  Future<List<Food>> getFoods() async {
    //nos devuelve un future que devuelve una lista de libros
    //apartir de mi referencia obtengo los datos y regresa la respuesta (query que contiene book)
    var result = await restaurantRef.get().then((value) => value);
    //obtiene los tres ultimos
    List<Food> foods = []; //lista vacia

    for (var doc in result.docs) {
      //se itera para cada uno de los docs(tablas) que vienen en mi resultado
      //se agrega el libro que viene en cada doc en su data a mi lista de libros books
      foods.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(foods);
  }
}
