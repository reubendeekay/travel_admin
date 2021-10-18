import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/screens/property_details/widgets/details_fullscreen.dart';

class TopImages extends StatefulWidget {
  final List<File> images;

  TopImages(this.images);
  @override
  _TopImagesState createState() => _TopImagesState();
}

class _TopImagesState extends State<TopImages> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> imageSliders = widget.images
        .map(
          (item) => GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(DetailsFullScreen.routeName, arguments: item),
            child: Hero(
              tag: item,
              child: Container(
                width: size.width,
                height: size.height * 0.4,
                child: Image.file(
                  item,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
        .toList();
    return Container(
      child: Column(
        children: [
          Container(
            height: size.height * 0.4,
            child: Stack(children: [
              CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    height: size.height * 0.4,
                    disableCenter: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Align(
                // bottom: 5,
                alignment: Alignment(1, 1),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                          width: _current == entry.key ? 8.0 : 6.0,
                          height: _current == entry.key ? 8.0 : 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? kPrimary
                                  : Colors.grey[300])),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
