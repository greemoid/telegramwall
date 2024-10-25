import 'dart:ui';

import 'package:durovswall/features/wall/presentation/widgets/view_in_telegram_button.dart';
import 'package:flutter/material.dart';

class VideoInCarouselWidget extends StatelessWidget {
  const VideoInCarouselWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Image.network(
          videoUrl,
          fit: BoxFit.contain,
        ),
      ),
      const ViewInTelegramButton(
        buttonText: 'View in Telegram',
      ),
    ]);
  }
}
