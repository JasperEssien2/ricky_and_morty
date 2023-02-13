import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ricky_and_morty/data/models/character_model.dart';

abstract class LocalDataSource {
  Future<List<CharacterModel>> getFavouriteCharacters();

  Future<bool> saveFavouriteCharacter(CharacterModel character);

  Future<bool> deleteFavouriteCharacter(int characterId);
}

class HiveDataSource extends LocalDataSource {
  Future<Box<String>> get openHiveBox async {
    const String boxName = 'favourites';

    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    return await Hive.openBox<String>(boxName);
  }

  @override
  Future<List<CharacterModel>> getFavouriteCharacters() async =>
      (await openHiveBox)
          .values
          .map((e) => CharacterModel.fromJson(e))
          .toList();

  @override
  Future<bool> deleteFavouriteCharacter(int characterId) async {
    await (await openHiveBox).delete(characterId);

    return true;
  }

  @override
  Future<bool> saveFavouriteCharacter(CharacterModel character) async {
    await (await openHiveBox).put(character.id, character.toJson());

    return true;
  }
}
