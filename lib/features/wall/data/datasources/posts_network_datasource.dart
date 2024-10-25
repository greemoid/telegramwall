import 'package:dio/dio.dart';
import 'package:durovswall/features/wall/data/models/media_model.dart';
import 'package:durovswall/features/wall/data/models/post_model.dart';
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

abstract interface class PostsNetworkDatasource {
  Future<List<PostModel>> parsePosts();
}

class PostsNetworkDataSourceImpl implements PostsNetworkDatasource {
  final Dio dio;

  PostsNetworkDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> parsePosts() async {
    try {
      final userId = TelegramWebApp.instance.initData.user.id;
      final start = DateTime.now();
      final response = await dio.get(
        'https://durovswall.pockethost.io/api/collections/tg_posts/records?filter=(userId=$userId)',
      );

      final items = response.data['items'];
      List<String> channelHtmlList = [];

      final gotFromNetwork = DateTime.now();
      GetIt.I<Talker>().warning(
          'Got htmls from network ${gotFromNetwork.millisecondsSinceEpoch - start.millisecondsSinceEpoch} milliseconds = ${(gotFromNetwork.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000} seconds');

      for (var item in items) {
        if (item['channelHtml'] != null) {
          channelHtmlList.add(item['channelHtml']);
        }
      }

      List<PostModel> listOfPosts = [];

      for (String channelHtml in channelHtmlList) {
        dom.Document document = parser.parse(channelHtml);

        final posts =
            document.getElementsByClassName('tgme_widget_message_wrap');
        for (final post in posts) {
          // Initialize or reset data for the current post
          var postTextHtml = '';
          var channel = '';
          String? avatarUrl = '';
          var dateTime = '';
          List<MediaModel> mediaUrls = [];
          var viewsCount = '';

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

          // Extract image urls
          List<dom.Element?> imageList = [];
          imageList
              .addAll(post.querySelectorAll('.tgme_widget_message_photo_wrap'));

          if (imageList.isNotEmpty) {
            for (var imageElement in imageList) {
              // Get the style attribute
              String? style = imageElement?.attributes['style'];
              String? imageUrl;
              // Use a regex to extract the URL from the style
              if (style != null) {
                final regex = RegExp(r"url\('?(.*?)'?\)", caseSensitive: false);
                final match = regex.firstMatch(style);
                if (match != null && match.groupCount > 0) {
                  imageUrl = match.group(1) ?? '';
                  mediaUrls.add(MediaModel(false, imageUrl, ''));
                  // imageUrls
                  //     .add(match.group(1) ?? ''); // Add the URL to the list
                }
              }
            }
          }

          // Parse the video link
          var videoElement =
              post.querySelector('a.tgme_widget_message_video_player');

          // Parse the video thumbnail (background image)
          var thumbElement =
              videoElement?.querySelector('.tgme_widget_message_video_thumb');
          String? style = thumbElement?.attributes['style'];
          String? thumbnailUrl;

          if (style != null) {
            final regex = RegExp(r"url\('?(.*?)'?\)", caseSensitive: false);
            final match = regex.firstMatch(style);
            if (match != null && match.groupCount > 0) {
              thumbnailUrl = match.group(1); // Get the thumbnail URL
              mediaUrls.add(MediaModel(true, '', thumbnailUrl));
            }
          }

          final postModel = PostModel(postTextHtml, channel, avatarUrl,
              dateTime, mediaUrls, '', viewsCount);

          listOfPosts.add(postModel);
        }
      }

      listOfPosts.sort((a, b) {
        DateTime dateA = DateTime.parse(a.dateTime ?? '');
        DateTime dateB = DateTime.parse(b.dateTime ?? '');
        return dateA.compareTo(dateB);
      });
      final end = DateTime.now();
      GetIt.I<Talker>().warning(
          'Parsed everything: ${end.millisecondsSinceEpoch - start.millisecondsSinceEpoch} milliseconds = ${(end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000} seconds');
      return listOfPosts;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return List.empty();
    }
  }
}
