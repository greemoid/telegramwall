import 'dart:ui';

import 'package:durovswall/features/wall/domain/media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

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
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                widget.avatarUrl,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/placeholder.png',
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                  );
                },
              ),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: FlutterCarousel(
              options: FlutterCarouselOptions(
                showIndicator: true,
                enableInfiniteScroll: false,
                slideIndicator: CircularSlideIndicator(),
              ),
              items: widget.mediaUrls.map((media) {
                return Builder(
                  builder: (BuildContext context) {
                    if (media.isVideo) {
                      return Stack(alignment: Alignment.center, children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Image.network(
                            media.videoUrl ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _isPressed = true;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _isPressed = false;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              _isPressed = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 1),
                            decoration: BoxDecoration(
                                color: _isPressed
                                    ? const Color(0xFFFFFFFF)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(color: Colors.white)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Text(
                              'View in telegram',
                              style: TextStyle(
                                color: _isPressed
                                    ? const Color(0xFF000000)
                                    : const Color(0xFFFFFFFF),
                                // Text color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    } else {
                      return InstaImageViewer(
                          child: Image.network(
                        media.imageUrl ?? '',
                        fit: BoxFit.contain,
                      ));
                    }
                  },
                );
              }).toList(),
            ),
          ),
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
