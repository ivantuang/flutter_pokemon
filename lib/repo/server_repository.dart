import 'package:flutter_pokemon/model/pokemon_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ServerRepository {

  late final Database _db;
  final String _dbName = 'pokemon_database.db';
  final String _tableName = 'pokemons';

  initData() async {
    _db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), _dbName),

        // When the database is first created, create a table to store pokemons.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE pokemons(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, desc TEXT, isFav INTEGER)',
        );
      }
    );
  }

  // Define a function that inserts pokemons into the database
  Future<void> insertPokemon(PokemonModel pokemonModel) async {
    // Insert the Pokemon into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await _db.insert(
      _tableName,
      pokemonModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all or specific pokemon from the pokemons table.
  Future<List<PokemonModel>> retrievePokemons() async {
    // Query the table for all The Pokemons.
    final List<Map<String, dynamic>> maps = await _db.query(_tableName);

    // Convert the List<Map<String, dynamic> into a List<PokemonModel>.
    return List.generate(maps.length, (i) {
      PokemonModel _pokemonModel = PokemonModel.fromJson(maps[i]);
      return _pokemonModel;
    });
  }

  // A method to update Pokemon details in pokemons table
  Future<void> updatePokemon(PokemonModel pokemonModel) async {
    // Update the given Pokemon.
    await _db.update(
      _tableName,
      pokemonModel.toJson(),
      // Ensure that the Pokemon has a matching id.
      where: 'id = ?',
      // Pass the Pokemon's id as a whereArg to prevent SQL injection.
      whereArgs: [pokemonModel.id],
    );
  }

  // A method to delete pokemon from the pokemons table
  Future<void> deletePokemon(PokemonModel pokemonModel) async {

    // Remove the Pokemon from the database.
    await _db.delete(
      _tableName,
      // Use a `where` clause to delete a specific Pokemon.
      where: 'id = ?',
      // Pass the Pokemon's id as a whereArg to prevent SQL injection.
      whereArgs: [pokemonModel.id],
    );
  }
}