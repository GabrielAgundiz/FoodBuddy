import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodbuddy/models/restaurants.dart';

class RestaurantService {
  final restaurantRef =
      FirebaseFirestore.instance.collection('restaurant').withConverter(
            fromFirestore: (snapshot, _) =>
                Restaurants.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (food, _) => food.toJson(),
          );

  Future<List<Restaurants>> getRestaurants() async {
    var result = await restaurantRef.get().then((value) => value);
    List<Restaurants> restaurants = []; //lista vacia

    for (var doc in result.docs) {
      restaurants.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(restaurants);
  }
}
