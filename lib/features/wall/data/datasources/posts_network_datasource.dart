import 'package:dio/dio.dart';
import 'package:durovswall/features/wall/data/models/post_model.dart';
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class PostsNetworkDatasource {
  Future<List<PostModel>> parsePosts();
}

class PostsNetworkDataSourceImpl implements PostsNetworkDatasource {
  final Dio dio;

  PostsNetworkDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> parsePosts() async {
    try {
      final response = await dio.get('https://t.me/s/book_uaa');
      dom.Document document = parser.parse(response.data);


      final posts = document.getElementsByClassName('tgme_widget_message_wrap');
      var postTextHtml = '';
      var channel = '';
      var dateTime = '';
      var imageUrl = '';
      var videoUrl = '';
      var viewsCount = '';
      List<PostModel> listOfPosts = [];
      for (final post in posts) {
        // Extract owner name
        var ownerElement =
        post.querySelector('.tgme_widget_message_owner_name');
        channel = ownerElement != null ? ownerElement.text.trim() : 'John Doe';

        // Extract post text
        var postElement = post.querySelector('.tgme_widget_message_text');
        postTextHtml = postElement != null ? postElement.innerHtml : '';

        // Extract views count
        var viewsElement = post.querySelector('.tgme_widget_message_views');
        viewsCount = viewsElement != null ? viewsElement.text.trim() : '';

        // Extract date of publish
        var dateElement = post.querySelector('.tgme_widget_message_date time');
        dateTime =
        (dateElement != null ? dateElement.attributes['datetime'] : '')!;
        final postModel = PostModel(
          postTextHtml,
          channel,
          dateTime,
          imageUrl,
          videoUrl,
          viewsCount,
        );

        listOfPosts.add(postModel);
      }
      for (final post in listOfPosts) {
        GetIt.I<Talker>().info(post.toString());
      }

      return listOfPosts;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return List.empty();
    }
  }
}
