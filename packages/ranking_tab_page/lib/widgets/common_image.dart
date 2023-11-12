import 'package:flutter/material.dart';
import 'package:services/image/ol_image.dart';

class CommonImage extends StatelessWidget {
  const CommonImage({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? OLImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
          )
        : Container(
            width: width,
            height: height,
            color: Colors.grey,
          );
  }
}
