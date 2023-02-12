import 'package:ricky_and_morty/domain/character_entity.dart';
import 'package:ricky_and_morty/domain/repository.dart';

class SaveFavouriteCharactersUseCase {
  SaveFavouriteCharactersUseCase({required Repository repository})
      : _repository = repository;

  final Repository _repository;

  Future<bool> call(CharacterEntity character) =>
      _repository.addFavourite(character);
}
