class Food {
  final String id;
  final String name;
  final String image;
  final String ingredients; // Cambiado a una lista para los ingredientes
  final String category;
  final double cal;
  final int time;
  final double rate;
  final int reviews;
  bool isLiked;

  Food(this.id, this.name, this.image, this.ingredients, this.category,
      this.cal, this.time, this.rate, this.reviews, this.isLiked);

  Food.fromJson(String id, Map<String, dynamic> json)
      : this(
            id,
            json['name'] as String,
            json['image'] as String,
            json['ingredients'] as String,
            json['category'] as String,
            json['cal'].toDouble(),
            json['time'].toInt(),
            json['rate'].toDouble(),
            json['reviews'].toInt(),
            json['isLiked'] as bool);
  toJson() {
    throw Exception();
  }
}

//obtener desde firebase
/*final List<Food> foods = [
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
      category: 'Vegetariano'),
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
      category: 'Vegetariano'),
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
      category: 'Vegano'),
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
      category: 'Vegetariano'),
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
      category: 'Vegano'),
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
      category: 'Vegetariano'),
  Food(
      name: "Berengenas rellenas",
      image:
          "https://cdn.recetasderechupete.com/wp-content/uploads/2021/08/Berenjenas-rellenas-de-atun-1200x828.jpg",
      cal: 140,
      time: 25,
      rate: 4.4,
      reviews: 23,
      isLiked: false,
      ingredients: "Berengenas",
      category: 'Vegetariano'),
  Food(
      name: "Ensalada Caprese con melocoton",
      image:
          "https://img-global.cpcdn.com/recipes/91a864f6bc3af36c/680x482cq70/ensalada-caprese-de-melocoton-foto-principal.jpg",
      cal: 450,
      time: 30,
      rate: 4.8,
      reviews: 20,
      isLiked: false,
      ingredients:
          "Mozzarella fresca, Tomates medianos, Durazo, Albahaca, Sal, Aceite de oliva, Vinagre de Módena",
      category: 'Vegetariano'),
  Food(
      name: "Torta Bacon Chicken Compo",
      image:
          "https://i.pinimg.com/564x/5a/d2/ee/5ad2ee1dcd1ee70d18b0e4218e497124.jpg",
      cal: 750,
      time: 30,
      rate: 4.8,
      reviews: 760,
      isLiked: false,
      ingredients:
          "Pechuga de pollo sazonada, Tocino, Queso Americano Blanco, Adereso Mayonesa - Chipotle",
      category: 'Vegetariano'),
  Food(
      name: "Grilled Chicken Pomodoro Combo",
      image:
          "https://img0.didiglobal.com/static/soda_public/do1_CbEmzDUDRTkVeasIzqcj?x-s3-process=image/resize,m_mfit,w_750,image/format,webp",
      cal: 600,
      time: 30,
      rate: 4.6,
      reviews: 365,
      isLiked: false,
      ingredients:
          "Pan Multigrano, Pollo, Queso Provolone, Toma, Espinaca, Albahaca,Mantequilla, Ajo",
      category: 'Vegetariano'),
  Food(
      name: "Fut Roll",
      image:
          "https://tb-static.uber.com/prod/image-proc/processed_images/a730d9532778265fb9902ae496387098/f0d1762b91fd823a1aa9bd0dab5c648d.jpeg",
      cal: 753,
      time: 15,
      rate: 4.2,
      reviews: 27,
      isLiked: false,
      ingredients: "Arroz frito, Aguacate, Camarón",
      category: 'Vegetariano'),
  Food(
      name: "Chicken Pannini",
      image:
          "https://tb-static.uber.com/prod/image-proc/processed_images/c4a6a3763d2e749bed8be5a18605f987/859baff1d76042a45e319d1de80aec7a.jpeg",
      cal: 753,
      time: 15,
      rate: 4.2,
      reviews: 27,
      isLiked: false,
      ingredients:
          "Chile Poblano, Pollo, Aguacate, Queso Gouda, Pimiento Asado, Espinaca",
      category: 'Vegetariano'),
  Food(
      name: "Consome de pollo",
      image: "https://i.blogs.es/716419/caldodepollo/1366_2000.jpg",
      cal: 400,
      time: 25,
      rate: 4.9,
      reviews: 4,
      isLiked: false,
      ingredients: "Vegetales, Pollo",
      category: 'Vegetariano'),
  Food(
      name: "Kipe bola vegano",
      image:
          "https://d1ralsognjng37.cloudfront.net/5060c33d-3637-492d-b8f1-a0dd5df4ab01.jpeg",
      cal: 400,
      time: 25,
      rate: 4.9,
      reviews: 4,
      isLiked: false,
      ingredients:
          "Leguminosas, Lentejas, Nuez sazonadas con condimentos libaneses",
      category: 'Vegano'),
  Food(
      name: "Tabouleh vegano",
      image:
          "https://d1ralsognjng37.cloudfront.net/93c14aa2-3670-4f11-b16f-3b93f1c173b2.jpeg",
      cal: 250,
      time: 25,
      rate: 4.7,
      reviews: 4,
      isLiked: false,
      ingredients:
          "Quinoa, Pepino, Tomate, Cebolla, Hierbabuena, Perejil,Cilantro",
      category: 'Vegano'),
  Food(
      name: "Gar-Nachos",
      image:
          "https://d1ralsognjng37.cloudfront.net/e0498797-efe6-4689-aa07-c2b674d17f4a.jpeg",
      cal: 420,
      time: 25,
      rate: 4.7,
      reviews: 4,
      isLiked: false,
      ingredients:
          "Totopos Frijoles Refritos, Queso Vegano, Guacamole, Guisado",
      category: 'Vegano'),
  Food(
      name: "Sopes Azules",
      image:
          "https://d1ralsognjng37.cloudfront.net/df4d59bd-0389-46f6-b8a3-fb9138b24b71.jpeg",
      cal: 650,
      time: 15,
      rate: 4.5,
      reviews: 4,
      isLiked: false,
      ingredients:
          "Maíz Azul, Frijoles Refritos, Queso, Crema, Lechuga, Tomate",
      category: 'Vegano'),
  Food(
      name: "Spicy Tuna Poke",
      image:
          "https://tb-static.uber.com/prod/image-proc/processed_images/d850cef33f0b5961ab6d39e6f8d7f1c5/5954bcb006b10dbfd0bc160f6370faf3.jpeg",
      cal: 500,
      time: 20,
      rate: 4.5,
      reviews: 54,
      isLiked: false,
      ingredients:
          "Atún spicy, Aguacate, Pepino, Edamames, Cebolla, Ajonjolí, Wasabi, Chipotle",
      category: 'Vegano'),
  Food(
      name: "Nieve gourmet chocolate saludable",
      image:
          "https://tb-static.uber.com/prod/image-proc/processed_images/a04da0921c91fea50e32b738e064b3bb/a19bb09692310dfd41e49a96c424b3a6.jpeg",
      cal: 390,
      time: 5,
      rate: 4.5,
      reviews: 24,
      isLiked: false,
      ingredients:
          "Leche de Almendras, Crema, Huevo, Agua, Leche de Coco, Cacao Organico, Azucar Morena, Vainilla, Fruta del Monje, Sal",
      category: 'Diabetico'),
  Food(
      name: "Muffin chocolate keto",
      image:
          "https://tb-static.uber.com/prod/image-proc/processed_images/34dfdbbfe7735512e47a336ed3bd3d9e/7f4ae9ca0446cbc23e71d8d395a98428.jpeg",
      cal: 36,
      time: 10,
      rate: 4.5,
      reviews: 30,
      isLiked: false,
      ingredients: "Guten, Sin Conservadores, Sin lácteos",
      category: 'Diabetico'),
  Food(
      name: "Carpaccio de bacalao con olivada",
      image:
          "https://content.clara.es/medio/2017/11/16/carpaccio-de-bacalao__600x900.jpg",
      cal: 237,
      time: 20,
      rate: 4.2,
      reviews: 26,
      isLiked: false,
      ingredients: "Frutas, verduras, setas, olivada de aceitunas",
      category: 'Diabetico'),
  Food(
      name: "Paella light",
      image:
          "https://content.clara.es/medio/2017/11/16/paella-light__600x900.jpg",
      cal: 250,
      time: 17,
      rate: 4.5,
      reviews: 40,
      isLiked: true,
      ingredients: "Arroz, aceite, marisco, gambas",
      category: 'Diabetico'),
  Food(
      name: "Aguacate relleno de ensalada y salmón",
      image:
          "https://content.clara.es/medio/2017/11/16/aguacate-relleno-de-ensalada-y-salmon__600x900.jpg",
      cal: 320,
      time: 15,
      rate: 4.3,
      reviews: 28,
      isLiked: false,
      ingredients: "Aguacate, ensalada, salmon ahumado",
      category: 'Vegano'),
  Food(
      name: "Lasaña fría de bonito",
      image:
          "https://content.clara.es/medio/2017/11/16/lasana-fria-de-bonito-baja-en-calorias__600x900.jpg",
      cal: 335,
      time: 20,
      rate: 4.1,
      reviews: 30,
      isLiked: false,
      ingredients: "Verdura asada, Bechamel",
      category: 'Vegano'),
  Food(
      name: "Ensalada de patatas y sardinas",
      image:
          "https://content.clara.es/medio/2017/11/16/ensalada-de-patatas-sardinas-y-curry__600x900.jpg",
      cal: 360,
      time: 20,
      rate: 4.2,
      reviews: 17,
      isLiked: false,
      ingredients: "Patatas, sardinas, apio",
      category: 'Vegano'),
  Food(
      name: "Espaguetis con gambas y almejas",
      image:
          "https://content.clara.es/medio/2017/11/16/espaguetis-con-gambas-y-almejas-bajos-en-calorias__600x900.jpg",
      cal: 394,
      time: 20,
      rate: 4.2,
      reviews: 25,
      isLiked: false,
      ingredients: "Pasta con salsa, queso, almejas",
      category: 'Vegano'),
  Food(
      name: "Canelones light de champiñones",
      image:
          "https://content.clara.es/medio/2022/09/23/recetas-con-champinones-canelones_3e928f42_1000x1500.jpg",
      cal: 275,
      time: 25,
      rate: 4.3,
      reviews: 35,
      isLiked: false,
      ingredients: "Setas, Bechamel ligera, leche desnatada",
      category: 'Vegano'),
  Food(
      name: "Arroz integral con verduras de temporada",
      image:
          "https://content.clara.es/medio/2022/09/23/recetas-con-arroz-integral-verduras-temporada_9f42f733_1000x1500.jpg",
      cal: 220,
      time: 25,
      rate: 4.3,
      reviews: 27,
      isLiked: false,
      ingredients: "Arros, verduras",
      category: 'Vegano'),
  Food(
      name: "Parrillada de verduras con vinagreta",
      image:
          "https://content.clara.es/medio/2017/11/16/trucos-adelgazar-rapido-parrillada-de-verduras__600x900.jpg",
      cal: 157,
      time: 24,
      rate: 4.4,
      reviews: 32,
      isLiked: false,
      ingredients: "Vinagreta de tomate, calabaza, apio",
      category: 'Vegano'),
  Food(
      name: "Crema de garbanzos",
      image:
          "https://content.clara.es/medio/2017/11/16/crema-de-garbanzos__600x900.jpg",
      cal: 215,
      time: 25,
      rate: 4.3,
      reviews: 32,
      isLiked: true,
      ingredients: "Garbanzos, verduras, hortalizas",
      category: 'Vegano'),
];*/
