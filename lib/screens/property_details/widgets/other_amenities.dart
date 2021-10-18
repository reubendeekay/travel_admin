import 'package:flutter/material.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/property_model.dart';

class OtherAmenities extends StatelessWidget {
  final PropertyModel property;
  OtherAmenities(this.property);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Additional Amenities',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(property.ammenities.length,
            (index) => amenity(property.ammenities[index])),
      ],
    );
  }

  Widget amenity(String name) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 11,
              backgroundColor: kPrimary,
              child: Icon(
                Icons.done,
                size: 14,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
