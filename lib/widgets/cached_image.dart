import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cachedImage(
  String url, {
  double width,
  double height,
  BoxFit fit,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: fit,
    progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        height: height,
        width: width,
        // color: Colors.grey,
        child: Shimmer.fromColors(
          child: Text(''),
          baseColor: Colors.grey,
          highlightColor: Colors.grey[200],
        )),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
