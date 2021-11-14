import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_admin/screens/property_review_details/widgets/details_fullscreen.dart';

class DetailsPhotos extends StatelessWidget {
  List<File> images;
  DetailsPhotos(this.images);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            'Photos',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    images.length, (index) => photos(images[index], context))),
          )
        ],
      ),
    );
  }

  Widget photos(File asset, BuildContext context) {
    return Container(
      height: 150,
      width: 120,
      margin: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(DetailsFullScreen.routeName, arguments: asset),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: asset,
            transitionOnUserGestures: true,
            child: Image.file(
              asset,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
