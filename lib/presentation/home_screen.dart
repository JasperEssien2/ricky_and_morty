import 'package:flutter/material.dart';

import 'package:ricky_and_morty/presentation/data_controllers.dart';
import 'package:ricky_and_morty/presentation/widgets/item_character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final charactersController = CharactersDataController();

  @override
  void initState() {
    charactersController.fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
            animation: charactersController,
            builder: (context, _) {
              if (charactersController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (charactersController.hasError) {
                return Center(
                  child: Text(
                    charactersController.error?.message ?? 'An error occurred!',
                  ),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: charactersController.characters.length,
                      itemBuilder: (context, index) {
                        final entity = charactersController.characters[index];

                        return ItemCharacterCard(
                          entity: entity,
                          onTap: () =>
                              charactersController.updateFavourite(entity.id),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Favourites',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: charactersController
                                  .favouriteCharacters.length,
                              itemBuilder: (context, index) =>
                                  ItemFavouriteCharacterCard(
                                entity: charactersController
                                    .favouriteCharacters[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    charactersController.dispose();

    super.dispose();
  }
}
