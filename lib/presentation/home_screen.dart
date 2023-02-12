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
  late final favouriteCharactersController =
      FavouriteCharactersDataController(controller: charactersController);

  @override
  void initState() {
    charactersController.fetch();
    favouriteCharactersController.fetch();
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
                    charactersController.error ?? 'An error occurred!',
                  ),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: charactersController.data.length,
                      itemBuilder: (context, index) {
                        final entity = charactersController.data[index];

                        return ItemCharacterCard(
                          entity: entity,
                          onTap: () => favouriteCharactersController
                              .addFavourite(entity),
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
                              itemCount:
                                  favouriteCharactersController.data.length,
                              itemBuilder: (context, index) =>
                                  ItemFavouriteCharacterCard(
                                entity:
                                    favouriteCharactersController.data[index],
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
    favouriteCharactersController.dispose();
    super.dispose();
  }
}
