import 'package:flutter/material.dart';
import 'package:flutter_pokemon/model/pokemon_model.dart';
import 'package:flutter_pokemon/repo/server_repository.dart';
import 'package:get/get.dart';

/// This is the ViewModel to handle most of the business logic
/// It will be extends by GetxController for state management
/// This view model will share by the PokemonListingPage for fav or non-fav
class PokemonViewModel extends GetxController {

  bool? isFav; /// The variable that indicate it's using for fav or non-fav
  late ServerRepository _serverRepository; /// The server repository that connecting to database
  List<PokemonModel?>? _pokemonList; /// The pokemon listing that use to display and get the details inside
  
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

  /// Method to determine the listing display by fav or non-fav
  void _updateListingFav() {
    if (isFav!) {
      _pokemonList?.removeWhere((element) => !(element?.isFav ?? false));
    }
    update();
  }

  /// Method to update the specific pokemon as fav or not
  void updatePokemonFav(int index) {
    PokemonModel? _selectedPokemonModel = _pokemonModel(index);
    
    if (_selectedPokemonModel != null) {
      /// Update the pokemon model fav
      _selectedPokemonModel.updateFav();
      /// Update to the table
      _serverRepository.updatePokemon(_selectedPokemonModel);
      /// Reload the view
      _updateListingFav();
    }
  }
}