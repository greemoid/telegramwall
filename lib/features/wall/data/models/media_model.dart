import 'package:durovswall/features/wall/domain/media.dart';

class MediaModel extends Media {
  MediaModel(super.isVideo, super.imageUrl, super.videoUrl);

  @override
  String toString() {
    return 'MediaModel{$isVideo, $imageUrl, $videoUrl}';
  }

  Media toMedia() => Media(isVideo, imageUrl, videoUrl);
}
