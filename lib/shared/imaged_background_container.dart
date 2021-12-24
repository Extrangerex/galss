import 'package:flutter/material.dart';

class ImagedBackgroundContainer extends StatelessWidget {
  final Widget child;

  const ImagedBackgroundContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: SafeArea(child: child),
      ),
    );
  }
}
