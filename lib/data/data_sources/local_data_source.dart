import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ricky_and_morty/data/models/stored_character_model.dart';

abstract class LocalDataSource {
  Future<List<StoredCharacterModel>> getFavouriteCharacters();

  Future<bool> saveFavouriteCharacter(StoredCharacterModel character);

  Future<bool> deleteFavouriteCharacter(int characterId);
}

class HiveDataSource extends LocalDataSource {
  Future<Box<StoredCharacterModel>> get openHiveBox async {
    const String boxName = 'favourites';

    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    return await Hive.openBox<StoredCharacterModel>(boxName);
  }

  @override
  Future<List<StoredCharacterModel>> getFavouriteCharacters() async =>
      (await openHiveBox).values.toList();

  @override
  Future<bool> deleteFavouriteCharacter(int characterId) async {
    await (await openHiveBox).delete(characterId);

    return true;
  }

  @override
  Future<bool> saveFavouriteCharacter(StoredCharacterModel character) async {
    await (await openHiveBox).put(character.id, character);

    return true;
  }
}
