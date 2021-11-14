import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_admin/models/property_model.dart';
import 'package:travel_admin/screens/manage_property/property_card.dart';

class AllProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('propertyData')
            .doc('propertyListing')
            .collection('properties')
            .where('ownerId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError || snapshot.data == null) {
            return Container();
          } else {
            List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: documents
                  .map((e) => PropertyCard(PropertyModel(
                        id: e.id,
                        name: e['name'],
                        coverImageString: e['coverImage'],
                        ammenities: e['ammenities'],
                        price: e['price'],
                        rating: double.parse(e['rating'].toString()),
                        views: e['views'],
                        location: PropertyLocation(
                          country: e['location']['country'],
                          latitude: e['location']['latitude'],
                          longitude: e['location']['longitude'],
                          town: e['location']['town'],
                        ),
                        imageUrls: e['images'],
                        reviews: e['reviews'],
                        ownerId: e['ownerId'],
                        ownerName: e['ownerName'],
                        propertyCategory: e['propertyCategory'],
                        description: e['description'],
                        offers: e['offers'],
                      )))
                  .toList(),
            );
          }
        });
  }
}
