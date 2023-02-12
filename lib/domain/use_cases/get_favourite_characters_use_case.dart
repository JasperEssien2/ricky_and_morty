import 'package:ricky_and_morty/domain/character_entity.dart';
import 'package:ricky_and_morty/domain/repository.dart';

class GetFavouriteCharactersUseCase {
  GetFavouriteCharactersUseCase({required Repository repository})
      : _repository = repository;

  final Repository _repository;

  Future<List<CharacterEntity>> call() => _repository.fetchFavourites();
}
