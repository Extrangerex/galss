import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'images.dart';

class CachedCircleAvatar extends StatelessWidget {
  final double? imgRadius;
  final String url;

  const CachedCircleAvatar({Key? key, required this.url, this.imgRadius = 64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeHolder = CircleAvatar(
      backgroundImage: profilePlaceholderImage,
      radius: imgRadius,
    );

    // TODO: implement build
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: imgRadius,
      ),
      imageUrl: url,
      placeholder: (context, url) => placeHolder,
      errorWidget: (context, url, error) => placeHolder,
    );
  }
}
