import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:foodbuddy/infraestructura/models/pokemon.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage>createState()=> _FeedPageState();
}

  class _FeedPageState extends State<FeedPage> {

  Pokemon? pokemon;
  int pokemonId = 0;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

    Future<void> getPokemon() async {
      //pokemonId++;
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/1');
      pokemon = Pokemon.fromJson(response.data);

      setState(() {});
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body:  Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
            'Bienvenido a la página de inicio',
            style: TextStyle(fontSize: 24),
            ), 
            Text(pokemon?.name ?? 'no data'),
             if ( pokemon != null )
            ...[
              Image.network(pokemon!.sprites.frontDefault),
              Image.network(pokemon!.sprites.backDefault),
            ]
          ],
        ),
      ),
    );
  }
  }
