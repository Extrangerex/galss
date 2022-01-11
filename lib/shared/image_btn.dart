import 'package:flutter/material.dart';

class ImageBtn extends StatelessWidget {
  final Function()? onPressed;
  final ImageProvider image;
  final double? size;
  final BoxFit fit;

  const ImageBtn(
      {Key? key,
      this.size,
      required this.image,
      this.fit = BoxFit.cover,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image(
        image: image,
        width: 128,
      ),
    );
  }
}
