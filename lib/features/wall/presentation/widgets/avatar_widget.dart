import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        avatarUrl,
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
    );
  }
}
