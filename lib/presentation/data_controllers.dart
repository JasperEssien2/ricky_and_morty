import 'package:flutter/material.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

import 'package:flutter/widgets.dart';

abstract class DataController<T> with ChangeNotifier {
  DataController({T? data}) : _data = data;

  T? get data => _data;
  T? _data;

  String? get error => _error;
  String? _error;

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

  Future<void> fetch();
}

class CharactersDataController extends DataController<List<CharacterEntity>> {
  CharactersDataController() {
    _data = [];
  }

  @override
  Future<void> fetch() async {
    state = ConnectionState.waiting;
    _data = [
      CharacterEntity(
        id: 0,
        name: 'Morty 1',
        specie: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      ),
      CharacterEntity(
        id: 1,
        name: 'Morty 2',
        specie: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      ),
      CharacterEntity(
        id: 2,
        name: 'Morty 3',
        specie: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      ),
    ];

    state = ConnectionState.done;
  }

  void updateFavouritedCharacters(List<int> characterIds) {
    state = ConnectionState.active;

    _data = _data!
        .map((e) => e.copyWith(isFavourited: characterIds.contains(e.id)))
        .toList();

    state = ConnectionState.done;
  }
}

class FavouriteCharactersDataController
    extends DataController<List<CharacterEntity>> {
  FavouriteCharactersDataController({required this.controller}) {
    _data = [];
  }

  final CharactersDataController controller;

  @override
  Future<void> fetch() async {
    state = ConnectionState.waiting;
    _data = [
      CharacterEntity(
        id: 0,
        name: 'Morty 1',
        specie: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      ),
    ];
    state = ConnectionState.done;
  }

  Future<void> addFavourite(CharacterEntity character) async {
    state = ConnectionState.active;

    if (_data!.contains(character)) {
      _data!.remove(character);
    } else {
      _data!.add(character);
    }
    controller.updateFavouritedCharacters(data!.map((e) => e.id).toList());
    state = ConnectionState.done;
  }
}
