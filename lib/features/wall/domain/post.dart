import 'package:durovswall/features/wall/domain/media.dart';

class Post {
  String? postTextHtml;
  String? channel;
  String? avatarUrl;
  String? dateTime;
  List<Media>? mediaUrl;
  String? videoUrl;
  String? viewsCount;

  Post(
    this.postTextHtml,
    this.channel,
    this.avatarUrl,
    this.dateTime,
    this.mediaUrl,
    this.videoUrl,
    this.viewsCount,
  );
}
