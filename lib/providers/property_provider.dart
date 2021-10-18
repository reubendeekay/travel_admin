import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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

    List<String> imageUrls = [];

    final coverData = await FirebaseStorage.instance
        .ref('property/propertyData/$id/coverImage/')
        .putFile(property.coverImage);
    final coverUrl = await coverData.ref.getDownloadURL();

    Future.forEach(property.images, (element) async {
      final key = UniqueKey();

      final urlData = await FirebaseStorage.instance
          .ref('property/propertyData/$id/images/${key.toString()}}')
          .putFile(element);
      final url = await urlData.ref.getDownloadURL();
      imageUrls.add(url);
    }).then(
      (_) => FirebaseFirestore.instance
          .collection('propertyData')
          .doc('propertyListing')
          .collection('properties')
          .doc(id)
          .set({
        'id': id,
        'description': property.description,
        'images': imageUrls,
        'name': property.name,
        'price': property.price,
        'propertyCategory': property.propertyCategory,
        'ownerId': property.ownerId,
        'rating': 0,
        'views': 0,
        'coverImage': coverUrl,
        'offers': [],
        'reviews': [],
        'ownerName': property.ownerName,
        'location': property.location.toJson(),
        'ammenities': property.ammenities,
        'createdAt': Timestamp.now(),
      }),
    );
    print('Property sent');

    notifyListeners();
  }
}
