import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class StoredCharacterModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? species;

  @HiveField(3)
  String? image;
}
