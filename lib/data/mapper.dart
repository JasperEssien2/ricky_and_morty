import 'package:ricky_and_morty/data/models/character_model.dart';
import 'package:ricky_and_morty/data/models/stored_character_model.dart';
import 'package:ricky_and_morty/domain/domain_export.dart';

abstract class Mapper<M, E> {
  M fromEntity(E entity);

  E toEntity(M model);
}

class _CharacterModelToEntityMapper
    extends Mapper<CharacterModel, CharacterEntity> {
  @override
  CharacterModel fromEntity(CharacterEntity entity) => CharacterModel(
        id: entity.id,
        name: entity.name,
        image: entity.image,
        species: entity.specie,
      );

  @override
  CharacterEntity toEntity(CharacterModel model) => CharacterEntity(
        id: model.id!,
        name: model.name!,
        specie: model.species!,
        image: model.image!,
      );
}

class _StoredCharacterModelToEntityMapper
    extends Mapper<StoredCharacterModel, CharacterEntity> {
  @override
  StoredCharacterModel fromEntity(CharacterEntity entity) =>
      StoredCharacterModel()
        ..id = entity.id
        ..image = entity.image
        ..name = entity.name
        ..species = entity.specie;

  @override
  CharacterEntity toEntity(StoredCharacterModel model) => CharacterEntity(
        id: model.id!,
        name: model.name!,
        specie: model.species!,
        image: model.image!,
      );
}

extension CharacterModelExt on CharacterModel {
  CharacterEntity get toEntity =>
      _CharacterModelToEntityMapper().toEntity(this);
}

extension StoredCharacterModelExt on StoredCharacterModel {
  CharacterEntity get toEntity =>
      _StoredCharacterModelToEntityMapper().toEntity(this);
}

extension CharacterEntityExt on CharacterEntity {
  CharacterModel get toCharacterModel =>
      _CharacterModelToEntityMapper().fromEntity(this);

  StoredCharacterModel get toStoredCharacterModel =>
      _StoredCharacterModelToEntityMapper().fromEntity(this);
}
