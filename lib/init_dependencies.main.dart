part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  final dio = Dio();
  serviceLocator.registerLazySingleton<Dio>(() => dio);

  _initWall();
}

void _initWall() {
  serviceLocator
    ..registerFactory<PostsNetworkDatasource>(
      () => PostsNetworkDataSourceImpl(
        dio: serviceLocator(),
      ),
    )
    ..registerFactory<PostsRepository>(
        () => PostsRepositoryImpl(networkDatasource: serviceLocator()))
    ..registerLazySingleton<PostsListBloc>(
        () => PostsListBloc(postsRepository: serviceLocator()));
}
