import 'package:flutter/material.dart';
import 'package:flutter_pokemon/viewmodels/pokemon_viewmodel.dart';
import 'package:flutter_pokemon/widgets/pokemon_widget.dart';
import 'package:get/get.dart';

class PokemonListingPage extends StatelessWidget {

  final bool? isFav;

  const PokemonListingPage({Key? key, this.isFav = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonViewModel>(
      init: PokemonViewModel(isFav),
      global: false,
      builder: (viewModel) {
        return ListView(
          padding: const EdgeInsets.all(20.0),
          children: viewModel.havePokemon ?
              List.generate(viewModel.pokemonCount, (index) {
               return PokemonWidget(
                 name: viewModel.pokemonName(index),
                 desc: viewModel.pokemonDesc(index),
                 isFav: viewModel.pokemonIsFav(index),
                 onTapFav: () => viewModel.updatePokemonFav(index),
               );
              }).toList() :
              []
          ,
        );
      },
    );
  }
}