class Restaurants {
  final String id;
  final String name;
  final String image;
  final double rate;
  final int reviews;
  final String address;

  Restaurants(
      this.id, this.name, this.image, this.rate, this.reviews, this.address);

  Restaurants.fromJson(String id, Map<String, dynamic> json)
      : this(
          id,
          json['name'] as String,
          json['image'] as String,
          json['rate'].toDouble(),
          json['reviews'].toInt(),
          json['address'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rate': rate,
      'reviews': reviews,
      'address': address,
    };
  }
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
