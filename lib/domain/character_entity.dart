// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharacterEntity {
  
  CharacterEntity({
    required this.id,
    required this.name,
    required this.specie,
    required this.gender,
    required this.image,
  });

    final int id;
  final String name;
  final String specie;
  final String gender;
  final String image;


  @override
  bool operator ==(covariant CharacterEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.specie == specie &&
      other.gender == gender &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      specie.hashCode ^
      gender.hashCode ^
      image.hashCode;
  }
}
