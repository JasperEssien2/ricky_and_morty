import 'package:flutter/material.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

abstract class DataController<T> extends ChangeNotifier {
  DataController(this._data);

  T get data => _data;
  T _data;

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

class CharactersDataController extends DataController<List<CharacterEntity>> {
  CharactersDataController(super.data);

  void fetchCharacters() {}
}

class FavouriteCharactersDataController
    extends DataController<List<CharacterEntity>> {
  FavouriteCharactersDataController(super.data);

  void fetchFavouriteCharacters() {}

  void updateFavourite() {}
}

class ControllerException implements Exception {
  const ControllerException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
