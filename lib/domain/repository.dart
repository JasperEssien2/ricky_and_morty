import 'package:ricky_and_morty/domain/character_entity.dart';

abstract class Repository {
  Future<List<CharacterEntity>> fetch();

  Future<bool> deleteFavourite(int id);

  Future<bool> addFavourite(CharacterEntity character);
}
