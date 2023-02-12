import 'package:flutter/material.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

class CharactersDataController extends ChangeNotifier {
  List<CharacterEntity> _characters = [];
  List<CharacterEntity> get characters => _characters;

  List<CharacterEntity> get favouriteCharacters =>
      characters.where((element) => element.isFavourited).toList();

  void fetchCharacters() {
    state = ConnectionState.waiting;
    _characters = [
      CharacterEntity(
          id: 0,
          name: 'Morty',
          specie: 'Human',
          image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg'),
      CharacterEntity(
          id: 1,
          name: 'Morty',
          specie: 'Human',
          image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg'),
      CharacterEntity(
          id: 3,
          name: 'Morty',
          specie: 'Human',
          image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg'),
    ];

    state = ConnectionState.done;
  }

  void updateFavourite(int id) {
    state = ConnectionState.active;

    final index = _characters.indexWhere((element) => element.id == id);

    if (index == -1) return;

    final character = _characters[index];

    if (character.isFavourited) {
      _characters[index] = character.copyWith(isFavourited: false);
    } else {
      _characters[index] = character.copyWith(isFavourited: true);
    }

    state = ConnectionState.done;
  }

  ControllerException? get error => _error;
  ControllerException? _error;

  @visibleForTesting
  ConnectionState get state => _state;
  ConnectionState _state = ConnectionState.none;

  set state(ConnectionState newState) {
    if (_state == newState) {
      return;
    }
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ConnectionState.waiting;

  bool get hasError => _state == ConnectionState.done && error != null;
}

class ControllerException implements Exception {
  const ControllerException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
