import 'package:get_it/get_it.dart';
import 'package:ricky_and_morty/domain/domain_export.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<GetCharactersUseCase>(
    () => GetCharactersUseCase(repository: locator.get()),
  );

  locator.registerFactory<GetFavouriteCharactersUseCase>(
    () => GetFavouriteCharactersUseCase(repository: locator.get()),
  );

  locator.registerFactory<SaveFavouriteCharactersUseCase>(
    () => SaveFavouriteCharactersUseCase(repository: locator.get()),
  );

  locator.registerFactory<DeleteFavouriteCharactersUseCase>(
    () => DeleteFavouriteCharactersUseCase(repository: locator.get()),
  );
}
