import 'package:flutter/material.dart';
import 'package:travel_admin/widgets/cached_image.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/helpers/country_helpers.dart';
import 'package:travel_admin/models/property_model.dart';
import 'package:travel_admin/screens/property_details/property_details_screen.dart';
import 'package:travel_admin/widgets/rating_bar.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  PropertyCard(this.property);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PropertyDetailsScreen.routeName, arguments: property);
      },
      child: Column(
        children: [
          Container(
            height: size.width * 0.25,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: cachedImage(property.coverImageString,
                          fit: BoxFit.cover)),
                  width: size.width * 0.3,
                  height: size.width * 0.25,
                ),
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          property.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${property.location.town}, ${countryAbbrevation(property.location.country)}',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Ratings(
                        size: 15,
                        rating: property.rating,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${property.price}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimary),
                          ),
                          Text(
                            ' per night',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: kPrimary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
