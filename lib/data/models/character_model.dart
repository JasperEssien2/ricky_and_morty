import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class CharacterModel {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final String? image;
  final String? url;
  final DateTime? created;

  const CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
    this.url,
    this.created,
  });

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, image: $image, url: $url, created: $created)';
  }

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    String? url,
    DateTime? created,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'url': url,
      'created': created?.millisecondsSinceEpoch,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      species: map['species'] != null ? map['species'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      created:
          map['created'] != null ? DateTime.tryParse(map['created']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CharacterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.status == status &&
        other.species == species &&
        other.type == type &&
        other.gender == gender &&
        other.image == image &&
        other.url == url &&
        other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        species.hashCode ^
        type.hashCode ^
        gender.hashCode ^
        image.hashCode ^
        url.hashCode ^
        created.hashCode;
  }
}
