import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  const ImageButton({
    required this.image,
    required this.clickImage,
    required this.onTap,
    required this.width,
    required this.height,
    super.key,
  });
  final Image image;
  final Image clickImage;
  final VoidCallback onTap;
  final double width;
  final double height;
  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _isPressed = true;
        setState(() {});
      },
      onTapUp: (_) {
        _isPressed = false;
        setState(() {});
        widget.onTap();
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: !_isPressed ? widget.image : widget.clickImage,
      ),
    );
  }
}
