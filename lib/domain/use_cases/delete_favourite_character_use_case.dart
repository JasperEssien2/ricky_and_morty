import 'package:ricky_and_morty/domain/repository.dart';

class DeleteFavouriteCharactersUseCase {
  DeleteFavouriteCharactersUseCase({required Repository repository})
      : _repository = repository;

  final Repository _repository;

  Future<bool> call(int id) => _repository.deleteFavourite(id);
}
