//elementos que se mostrara de cada restaurante presentacion 

class Local {
  String name;
  int time;
  String image;
  double stars;

  Local({
    required this.name,
    required this.time,
    required this.image,
    required this.stars,
  });
}

//Lista de locales a mostrar 
List<Local> locales(){
  return[
    Local(
      name: "Nombre restaurante",
      time: 5, //tiempo de espera aprox o ver que<---------------------------------------------
      image: "imagen.png del local", //colocar en carpeta images
      stars: 5,
    ),
  ];
}

