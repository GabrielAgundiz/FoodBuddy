import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference foodCollection =
    FirebaseFirestore.instance.collection('foods');

Future<void> updateFoodsInFirebase(List<Food> foods) async {
  for (var food in foods) {
    await foodCollection.doc(food.name).update({
      'name': food.name,
      'image': food.image,
      'cal': food.cal,
      'time': food.time,
      'rate': food.rate,
      'reviews': food.reviews,
      'isLiked': food.isLiked,
      'ingredients': food.ingredients,
    });
  }
}

// Llamada a la función para actualizar los alimentos en Firebase
Future<void> updateFoods() async {
  // Llamada a la función para actualizar los alimentos en Firebase
  await updateFoodsInFirebase(foods);
}

void main() {
  // Llamar a la función asincrónica dentro de main
  updateFoods();
}

class Food {
  String name;
  String image;
  String ingredients; // Cambiado a una lista para los ingredientes
  String category;
  double cal;
  double time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
    required this.ingredients,
    required this.category,
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen",
    image:
        "https://www.kikkoman.es/fileadmin/_processed_/d/2/csm_1107-recipe-page-Mexican-ramen_desktop_0c7ddb8608.jpg",
    cal: 120,
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
    ingredients:
        "Ramen, Elote, Pasta de miso, Salsa de soja, Aceite de sesamo, Ajo picado, Chile picado, Jengibre rallado, Espinacas",
        category: 'Vegetariano'
  ),
  Food(
    name: "Ensalada Mediterranea",
    image: "https://cdn7.kiwilimon.com/recetaimagen/39720/52119.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
    ingredients:
        "Lechuga fresca, Tomates cherry, Pepino cortado, Aceitunas kalamata, Queso feta, Cebolla roja, Albahaca picada, Jugo de limon, Aceite de oliva",
         category: 'Vegetariano'
  ),
  Food(
    name: "Tacos de Setas",
    image: "https://cdn7.kiwilimon.com/recetaimagen/39356/51359.jpg",
    cal: 130,
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
    ingredients:
        "Setas frescas, Tortillas de maiz, Aceite de oliva, Cebolla picada, Ajo picado, Chile picado, Comino en polvo, Salsas al gusto",
         category: 'Vegetariano'
  ),
  Food(
    name: "Boneless de Coliflor",
    image: "https://cdn7.kiwilimon.com/recetaimagen/38387/49194.jpg",
    cal: 110,
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
    ingredients:
        "Colifor fresa, Harina de trigo, Pan rallado, Huevos batidos, Salsa picante o salsa bbq, Mantequlla, Sal, Pimienta",
         category: 'Vegetariano'
  ),
  Food(
    name: "Sopes Vegetales",
    image: "https://cdn7.kiwilimon.com/recetaimagen/35530/42718.jpg",
    cal: 150,
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
    ingredients:
        "Calabacin cortado, Zanahoria rallada, Champinones en rodajas, Pimientos picados, Cebolla picada, Chiles jalapenos, Maiz desgranado, Queso, Salsa roja",
         category: 'Vegetariano'
  ),
  Food(
    name: "Croquetas de Espinaca",
    image: "https://cdn7.kiwilimon.com/recetaimagen/34912/40664.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
    ingredients:
        "Espinacas, Harina de trigo, Leche, Mantequilla, Queso rallado, Cebolla picada, Ajo picado, Aceite vegetal",
         category: 'Vegetariano'
  ),
  Food(
    name: "Berengenas rellenas",
    image: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.recetasderechupete.com%2Fwp-content%2Fuploads%2F2021%2F08%2FBerenjenas-rellenas-de-atun-1200x828.jpg&tbnid=AcG3E2WIRJuWwM&vet=12ahUKEwjvtMb1nPKEAxX91MkDHXbfBhQQMygAegQIARBd..i&imgrefurl=https%3A%2F%2Fwww.abc.es%2Frecetasderechupete%2Fberenjenas-rellenas-de-atun-con-queso-gratinado-al-horno%2F42592%2F&docid=oLKol0CUChlDqM&w=1200&h=828&q=berenjenas%20rellenas&ved=2ahUKEwjvtMb1nPKEAxX91MkDHXbfBhQQMygAegQIARBd",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
    ingredients:
        "Berengenas",
         category: 'Vegetariano'
  ),
];
