import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:ricky_and_morty/domain/domain_export.dart';

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
  CharactersDataController({required this.getCharactersUseCase}) {
    _data = [];
  }

  final GetCharactersUseCase getCharactersUseCase;

  List<int> _favouritedIds = [];

  @override
  Future<void> fetch() async {
    state = ConnectionState.waiting;

    try {
      _data = await getCharactersUseCase();
    } catch (e) {
      _error = e.toString();
    }
    updateFavouritedCharacters();
    state = ConnectionState.done;
  }

  void updateFavouritedCharacters({List<int>? characterIds}) {
    state = ConnectionState.active;

    if (characterIds != null) {
      _favouritedIds = characterIds;
    }

    _data = data!
        .map((e) => e.copyWith(isFavourited: _favouritedIds.contains(e.id)))
        .toList();

    state = ConnectionState.done;
  }
}

class FavouriteCharactersDataController
    extends DataController<List<CharacterEntity>> {
  FavouriteCharactersDataController({
    required this.controller,
    required this.getFavouriteCharactersUseCase,
    required this.saveFavouriteCharactersUseCase,
    required this.deleteFavouriteCharactersUseCase,
  }) {
    _data = [];
  }

  final GetFavouriteCharactersUseCase getFavouriteCharactersUseCase;
  final SaveFavouriteCharactersUseCase saveFavouriteCharactersUseCase;
  final DeleteFavouriteCharactersUseCase deleteFavouriteCharactersUseCase;
  final CharactersDataController controller;

  @override
  Future<void> fetch() async {
    state = ConnectionState.waiting;

    try {
      _data = await getFavouriteCharactersUseCase();
    } catch (e) {
      _error = e.toString();
    }
    _updateFavouriteList();
    state = ConnectionState.done;
  }

  Future<void> addFavourite(CharacterEntity character) async {
    state = ConnectionState.active;

    try {
      if (_data!.contains(character)) {
        await deleteFavouriteCharactersUseCase(character.id);
      } else {
        await saveFavouriteCharactersUseCase(character);
      }
    } catch (e) {
      _error = e.toString();
    }

    fetch();
    state = ConnectionState.done;
  }

  void _updateFavouriteList() {
    controller.updateFavouritedCharacters(
      characterIds: data!.map((e) => e.id).toList(),
    );
  }
}
