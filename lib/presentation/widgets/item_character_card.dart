import 'package:flutter/material.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

class ItemCharacterCard extends StatelessWidget {
  const ItemCharacterCard({super.key, required this.entity});

  final CharacterEntity entity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(-2, -2),
          blurRadius: 5,
          spreadRadius: 5,
        )
      ]),
      child: ListTile(
        leading: Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(entity.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          entity.name,
          style: theme.bodyLarge,
        ),
        subtitle: Text(
          entity.specie,
          style: theme.bodySmall,
        ),
        trailing: Icon(
            entity.gender.toLowerCase() == 'male' ? Icons.male : Icons.female),
      ),
    );
  }
}
