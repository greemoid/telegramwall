import 'package:durovswall/features/wall/data/datasources/posts_network_datasource.dart';
import 'package:durovswall/features/wall/domain/post.dart';
import 'package:durovswall/features/wall/domain/posts_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsNetworkDatasource networkDatasource;

  PostsRepositoryImpl({
   required this.networkDatasource
});

  @override
  Future<List<Post>> getPostsFromChannel() async {
    try {
      final result = await networkDatasource.parsePosts();
      return result;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return List.empty();
    }
  }

}