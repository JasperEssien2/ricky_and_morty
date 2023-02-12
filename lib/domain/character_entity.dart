// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharacterEntity {
  CharacterEntity({
    required this.id,
    required this.name,
    required this.specie,
    required this.image,
    this.isFavourited = false,
  });

  final int id;
  final String name;
  final String specie;
  final String image;
  final bool isFavourited;

  @override
  bool operator ==(covariant CharacterEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.specie == specie &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ specie.hashCode ^ image.hashCode;
  }

  CharacterEntity copyWith({
    int? id,
    String? name,
    String? specie,
    String? image,
    bool? isFavourited,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      specie: specie ?? this.specie,
      image: image ?? this.image,
      isFavourited: isFavourited ?? this.isFavourited,
    );
  }
}
