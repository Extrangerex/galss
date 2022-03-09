import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({Key? key, required this.imageUrl, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: SizedBox.expand(
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              panEnabled: false,
              maxScale: 3,
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
