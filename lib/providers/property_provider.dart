import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_admin/models/property_model.dart';

class PropertyProvider with ChangeNotifier {
  List<PropertyModel> _properties;

  List<PropertyModel> get properties => [..._properties];

  Future<void> sendProperty(PropertyModel property) async {
    final id = FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties')
        .doc()
        .id;

    FirebaseFirestore.instance
        .collection('propertyData')
        .doc('propertyListing')
        .collection('properties')
        .doc(id)
        .set({
      'id': id,
      'description': property.description,
      'images': property.images,
      'name': property.name,
      'price': property.price,
      'propertyCategory': property.propertyCategory,
      'ownerId': property.ownerId,
      'coverImage': property.coverImage,
      'offers': property.offers.map((e) => e.toJson()).toList(),
      'reviews': property.reviews.map((e) => e.toJson()).toList(),
      'ownerName': property.propertyOwner,
      'location': property.location.toJson(),
      'ammenities': property.ammenities,
    });

    notifyListeners();
  }
}
