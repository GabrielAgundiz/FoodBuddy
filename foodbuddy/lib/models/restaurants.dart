class Restaurants {
  String name;
  String image;
  double rate;
  int reviews;
  String address;

  Restaurants({
    required this.name,
    required this.image,
    required this.address,
    required this.rate,
    required this.reviews,
  });
}

/*final List<Restaurant> restaurants = [
  Restaurant(
      name: "Don Pancho",
      image:
          "https://www.kikkoman.es/fileadmin/_processed_/d/2/csm_1107-recipe-page-Mexican-ramen_desktop_0c7ddb8608.jpg",
      rate: 4.4,
      reviews: 23,
      addres: "Pancho Villa #123, Monterrey, N.L."
  ),
];*/
