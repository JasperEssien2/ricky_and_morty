import 'package:ricky_and_morty/data/data_sources/local_data_source.dart';
import 'package:ricky_and_morty/data/data_sources/remote_data_source.dart';
import 'package:ricky_and_morty/data/mapper.dart';
import 'package:ricky_and_morty/domain/domain_export.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<bool> addFavourite(CharacterEntity character) async {
    return localDataSource
        .saveFavouriteCharacter(character.toStoredCharacterModel);
  }

  @override
  Future<bool> deleteFavourite(int id) async =>
      localDataSource.deleteFavouriteCharacter(id);

  @override
  Future<List<CharacterEntity>> fetch() async =>
      (await remoteDataSource.getCharacters()).map((e) => e.toEntity).toList();

  @override
  Future<List<CharacterEntity>> fetchFavourites() async =>
      (await localDataSource.getFavouriteCharacters())
          .map((e) => e.toEntity)
          .toList();
}
