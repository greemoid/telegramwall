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
      final response = await dio.get(
        // 'https://corsproxy.io/?https://t.me/s/book_uaa',
        'https://durovswall.pockethost.io/api/collections/tg_posts/records',
        // options: Options(
        //   headers: {
        //     "Access-Control-Allow-Origin": "*",
        //     // Required for CORS support to work
        //     "Access-Control-Allow-Credentials": true,
        //     // Required for cookies, authorization headers with HTTPS
        //     "Access-Control-Allow-Headers":
        //         "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        //     "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
        //   },
      );
      // todo: handle return codes
      // GetIt.I<Talker>().info(response.data);
      // return (response.data as List).map((json) => PostModel.fromJson(json)).toList();

      // GetIt.I<Talker>().info(response.data['items']);

      final items = response.data['items'];
      List<String> channelHtmlList = [];

      for (var item in items) {
        if (item['channelHtml'] != null) {
          channelHtmlList.add(item['channelHtml']);
        }
      }

      List<PostModel> listOfPosts = [];

      for (String channelHtml in channelHtmlList) {
        dom.Document document = parser.parse(channelHtml);
        // Process the document as needed...

        final posts =
            document.getElementsByClassName('tgme_widget_message_wrap');
        var postTextHtml = '';
        var channel = '';
        String? avatarUrl = '';
        var dateTime = '';
        var imageUrl = '';
        var videoUrl = '';
        var viewsCount = '';
        for (final post in posts) {
          // Extract owner name
          var ownerElement =
              post.querySelector('.tgme_widget_message_owner_name');
          channel =
              ownerElement != null ? ownerElement.text.trim() : 'John Doe';

          // Extract post text
          var postElement = post.querySelector('.tgme_widget_message_text');
          postTextHtml = postElement != null ? postElement.innerHtml : '';

          // Extract channel's avatar
          var avatarElement =
              post.querySelector('.tgme_widget_message_user_photo img');
          avatarUrl =
              avatarElement != null ? avatarElement.attributes['src'] : '';

          // Extract views count
          var viewsElement = post.querySelector('.tgme_widget_message_views');
          viewsCount = viewsElement != null ? viewsElement.text.trim() : '';

          // Extract date of publish
          var dateElement =
              post.querySelector('.tgme_widget_message_date time');
          dateTime =
              (dateElement != null ? dateElement.attributes['datetime'] : '')!;
          final postModel = PostModel(
              postTextHtml, channel, avatarUrl, dateTime, '', '', viewsCount);

          listOfPosts.add(postModel);

          // GetIt.I<Talker>().warning(listOfPosts.length);
        }
      }

      listOfPosts.sort((a,b) {
        DateTime dateA = DateTime.parse(a.dateTime ?? '');
        DateTime dateB = DateTime.parse(b.dateTime ?? '');
        return dateA.compareTo(dateB);
      });
      return listOfPosts;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return List.empty();
    }
  }
}
