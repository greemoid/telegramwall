import 'package:flutter/material.dart';

class ViewInTelegramButton extends StatefulWidget {
  const ViewInTelegramButton({super.key, required this.buttonText});

  final String buttonText;

  @override
  State<ViewInTelegramButton> createState() => _ViewInTelegramButtonState();
}

class _ViewInTelegramButtonState extends State<ViewInTelegramButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            color: _isPressed ? const Color(0xFFFFFFFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Colors.white)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          'View in telegram',
          style: TextStyle(
            color:
                _isPressed ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
            // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
