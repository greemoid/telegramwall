import 'package:durovswall/features/wall/domain/media.dart';
import 'package:durovswall/features/wall/presentation/widgets/media_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'avatar_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.title,
    required this.postTextHtml,
    required this.avatarUrl,
    required this.mediaUrls,
  });

  final String title;
  final String postTextHtml;
  final String avatarUrl;
  final List<Media> mediaUrls;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AvatarWidget(
              avatarUrl: widget.avatarUrl,
            ),
            const SizedBox(width: 12),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (widget.mediaUrls.isNotEmpty)
          MediaCarouselWidget(mediaUrls: widget.mediaUrls)
        else
          const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: HtmlWidget(
            enableCaching: true,
            widget.postTextHtml,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
