import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:travel_admin/constants.dart';

class Ratings extends StatefulWidget {
  final double size;
  final bool isEdit;
  final double rating;
  Ratings({this.size, this.isEdit, this.rating});

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  double _rating = .50;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isEdit == null
          ? RatingBar.readOnly(
              initialRating: widget.rating,
              isHalfAllowed: true,
              filledColor: Colors.amber,
              size: widget.size == null ? 14.0 : widget.size,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            )
          : RatingBar(
              onRatingChanged: (rating) => setState(() => _rating = rating),
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledIcon: Icons.star_half,
              isHalfAllowed: true,
              filledColor: kPrimary,
              emptyColor: Colors.amber,
              halfFilledColor: kPrimary,
              size: widget.size == null ? 14.0 : widget.size,
            ),
    );
  }
}
