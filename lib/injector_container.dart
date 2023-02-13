import 'package:get_it/get_it.dart';
import 'package:ricky_and_morty/data/data_sources/local_data_source.dart';
import 'package:ricky_and_morty/data/data_sources/remote_data_source.dart';
import 'package:ricky_and_morty/data/repository_impl.dart';
import 'package:ricky_and_morty/domain/domain_export.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: DioDataSource(),
      localDataSource: HiveDataSource(),
    ),
  );

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
