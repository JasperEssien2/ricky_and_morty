import 'package:flutter/material.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

class ItemCharacterCard extends StatelessWidget {
  const ItemCharacterCard({
    super.key,
    required this.entity,
    required this.onTap,
  });

  final CharacterEntity entity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 10,
            color: Colors.grey[100]!,
          )
        ],
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: _ImageWidget(entity: entity),
        title: Text(
          entity.name,
          style: theme.bodyLarge,
        ),
        subtitle: Text(
          entity.specie,
          style: theme.bodySmall,
        ),
        trailing: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite,
              color: entity.isFavourited ? Colors.red : Colors.grey[200],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemFavouriteCharacterCard extends StatelessWidget {
  const ItemFavouriteCharacterCard({super.key, required this.entity});

  final CharacterEntity entity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: SizedBox(
        width: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageWidget(
              entity: entity,
              size: const Size(130, 100),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(entity.name, style: textTheme.bodyLarge)),
                    Text(
                      entity.specie,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.entity,
    // ignore: unused_element
    this.size,
  });

  final CharacterEntity entity;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.height ?? 60,
      width: size?.width ?? 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(entity.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
