import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/property_model.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/providers/property_provider.dart';

class PropertyReviews extends StatelessWidget {
  final PropertyModel property;
  PropertyReviews({@required this.property});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  child: Row(children: [
                    const Text(
                      'Give a Review',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kPrimary,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.comment,
                      color: kPrimary,
                      size: 16,
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Text(
            'Customer Reviews\t(${property.reviews.length})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: Center(child: Text('Reviews will be here')),
          ),
        ],
      ),
    );
  }
}
