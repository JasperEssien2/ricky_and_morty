import 'dart:async';

import 'package:hive/hive.dart';
import 'package:ricky_and_morty/data/models/stored_character_model.dart';

abstract class LocalDataSource {
  FutureOr<List<StoredCharacterModel>> getFavouriteCharacters();

  FutureOr<bool> saveFavouriteCharacter(StoredCharacterModel character);

  FutureOr<bool> deleteFavouriteCharacter(int characterId);
}

class HiveDataSource extends LocalDataSource {
  final box = Hive.box<StoredCharacterModel>('favourites');

  @override
  FutureOr<List<StoredCharacterModel>> getFavouriteCharacters() =>
      box.values.toList();

  @override
  FutureOr<bool> deleteFavouriteCharacter(int characterId) async {
    await box.delete(characterId);

    return true;
  }

  @override
  FutureOr<bool> saveFavouriteCharacter(StoredCharacterModel character) async {
    await box.put(character.id, character);

    return true;
  }
}
