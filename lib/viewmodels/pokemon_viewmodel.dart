import 'package:flutter/material.dart';
import 'package:flutter_pokemon/model/pokemon_model.dart';
import 'package:flutter_pokemon/repo/server_repository.dart';
import 'package:get/get.dart';

class PokemonViewModel extends GetxController {

  bool? isFav;
  late ServerRepository _serverRepository;
  List<PokemonModel?>? _pokemonList;
  
  PokemonViewModel(bool? isFav) {
    this.isFav = isFav ?? false;
    _serverRepository = Get.find<ServerRepository>();
  }
  
  @override
  void onReady() async {
    _pokemonList = await _serverRepository.retrievePokemons();
    _updateListingFav();
    super.onReady();
  }

  List<PokemonModel?>? get pokemonList => _pokemonList;
  int get pokemonCount => _pokemonList?.length ?? 0;
  bool get havePokemon => pokemonCount > 0;
  PokemonModel? _pokemonModel(int index) => _pokemonList?.elementAt(index);
  String pokemonName(int index) => _pokemonList?.elementAt(index)?.name ?? '';
  String pokemonDesc(int index) => _pokemonList?.elementAt(index)?.desc ?? '';
  bool pokemonIsFav(int index) => _pokemonList?.elementAt(index)?.isFav ?? false;

  void _updateListingFav() {
    if (isFav!) {
      _pokemonList?.removeWhere((element) => !(element?.isFav ?? false));
    }
    update();
  }
  
  void updatePokemonFav(int index) {
    PokemonModel? _selectedPokemonModel = _pokemonModel(index);
    
    if (_selectedPokemonModel != null) {
      _selectedPokemonModel.updateFav();
      _serverRepository.updatePokemon(_selectedPokemonModel);
      _updateListingFav();
    }
  }
}