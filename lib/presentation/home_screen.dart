import 'package:flutter/material.dart';
import 'package:ricky_and_morty/injector_container.dart';
import 'package:ricky_and_morty/domain/character_entity.dart';

import 'package:ricky_and_morty/presentation/data_controllers.dart';
import 'package:ricky_and_morty/presentation/widgets/item_character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final charactersController = CharactersDataController(
    getCharactersUseCase: locator.get(),
  );

  late final favouriteCharactersController = FavouriteCharactersDataController(
    controller: charactersController,
    saveFavouriteCharactersUseCase: locator.get(),
    deleteFavouriteCharactersUseCase: locator.get(),
    getFavouriteCharactersUseCase: locator.get(),
  );

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Consumer(
                dataController: charactersController,
                child: ListView.builder(
                  itemCount: charactersController.data.length,
                  itemBuilder: (context, index) {
                    final entity = charactersController.data[index];

                    return ItemCharacterCard(
                      entity: entity,
                      onTap: () =>
                          favouriteCharactersController.addFavourite(entity),
                    );
                  },
                ),
              ),
            ),
            Flexible(
              child: Consumer(
                dataController: favouriteCharactersController,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Favourites (${favouriteCharactersController.data.length})',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: favouriteCharactersController.data.length,
                          itemBuilder: (context, index) =>
                              ItemFavouriteCharacterCard(
                            entity: favouriteCharactersController.data[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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

class Consumer extends StatelessWidget {
  const Consumer({
    super.key,
    required this.dataController,
    required this.child,
  });

  final DataController<List<CharacterEntity>> dataController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: dataController,
      builder: (context, _) {
        if (dataController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (dataController.hasError) {
          return Center(
            child: Text(
              dataController.error ?? 'An error occurred!',
            ),
          );
        } else if (dataController.data.isEmpty) {
          return const Center(
            child: Text('No data to display'),
          );
        }

        return child;
      },
    );
  }
}
