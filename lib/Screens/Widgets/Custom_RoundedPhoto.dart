import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomRoundedPhoto extends StatelessWidget {
  final double? radius;
  final String image;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const CustomRoundedPhoto({
    Key? key,
    this.radius,
    required this.image,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 65,
      child: Container(
          padding: EdgeInsets.all(borderWidth ?? 3),
          decoration: BoxDecoration(
              color: borderColor ?? Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 65),
              boxShadow: boxShadow),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 65),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.grey,
                ),
              ),
            ),
          )
          // Image.asset(Assets.lib.assets.images.centerAvatar.path),
          ),
    );
  }
}
