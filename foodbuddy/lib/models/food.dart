class Food {
  String name;
  String image;
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
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen",
    image: "https://www.kikkoman.es/fileadmin/_processed_/d/2/csm_1107-recipe-page-Mexican-ramen_desktop_0c7ddb8608.jpg",
    cal: 120,
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Ensalada Mediterranea",
    image: "https://cdn7.kiwilimon.com/recetaimagen/39720/52119.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Tacos de Setas",
    image: "https://cdn7.kiwilimon.com/recetaimagen/39356/51359.jpg",
    cal: 130,
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "Boneless de Coliflor",
    image: "https://cdn7.kiwilimon.com/recetaimagen/38387/49194.jpg",
    cal: 110,
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
  ),
  Food(
    name: "Sopes Vegetales",
    image: "https://cdn7.kiwilimon.com/recetaimagen/35530/42718.jpg",
    cal: 150,
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Croquetas de Espinaca",
    image: "https://cdn7.kiwilimon.com/recetaimagen/34912/40664.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
];