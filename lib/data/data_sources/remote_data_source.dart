import 'package:dio/dio.dart';
import 'package:ricky_and_morty/data/models/character_model.dart';

abstract class RemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
}

class DioDataSource extends RemoteDataSource {
  final dio = Dio();

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/character');

      return (response.data['results'] as List)
          .map((e) => CharacterModel.fromMap(e))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data.toString() ?? 'An error occurred');
      } else {
        throw Exception('An error occurred');
      }
    }
  }
}
