import 'package:durovswall/features/wall/domain/post.dart';

class PostModel extends Post {
  PostModel(
    super.postTextHtml,
    super.channel,
    super.avatarUrl,
    super.dateTime,
    super.imageUrl,
    super.videoUrl,
    super.viewsCount,
  );

  @override
  String toString() {
    return 'PostModel{$postTextHtml $channel $avatarUrl $dateTime $imageUrl $videoUrl $viewsCount}';
  }

  Post toPost() {
    return Post(postTextHtml, channel, avatarUrl, dateTime, imageUrl, videoUrl,
        viewsCount);
  }
}
