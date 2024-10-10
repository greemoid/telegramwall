
import 'package:durovswall/features/wall/domain/post.dart';

abstract interface class PostsRepository {
  Future<List<Post>> getPostsFromChannel();
}