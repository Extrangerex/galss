import 'package:flutter/material.dart';

class ImagedBackgroundContainer extends StatelessWidget {
  final Widget child;
  final Size? size;

  const ImagedBackgroundContainer({required this.child, Key? key, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _child = Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: SafeArea(child: child));

    if (size != null) {
      return SizedBox(
        height: size?.height,
        width: size?.width,
        child: _child,
      );
    }

    // TODO: implement build
    return SizedBox.expand(
      child: _child,
    );
  }
}
