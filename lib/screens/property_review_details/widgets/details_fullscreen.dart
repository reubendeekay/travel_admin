import 'package:flutter/material.dart';

class DetailsFullScreen extends StatelessWidget {
  static const routeName = '/details-fullscreen';

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context).settings.arguments;
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Hero(
        tag: image,
        transitionOnUserGestures: true,
        child: Image.file(
          image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
