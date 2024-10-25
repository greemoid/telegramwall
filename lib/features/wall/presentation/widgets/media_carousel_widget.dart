import 'package:durovswall/features/wall/domain/media.dart';
import 'package:durovswall/features/wall/presentation/widgets/video_in_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class MediaCarouselWidget extends StatelessWidget {
  const MediaCarouselWidget({super.key, required this.mediaUrls});

  final List<Media> mediaUrls;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: FlutterCarousel(
        options: FlutterCarouselOptions(
          showIndicator: true,
          enableInfiniteScroll: false,
          slideIndicator: CircularSlideIndicator(),
        ),
        items: mediaUrls.map((media) {
          return Builder(
            builder: (BuildContext context) {
              if (media.isVideo) {
                return VideoInCarouselWidget(videoUrl: media.videoUrl ?? '');
              } else {
                return InstaImageViewer(
                  child: Image.network(
                    media.imageUrl ?? '',
                    fit: BoxFit.contain,
                  ),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
