import 'package:cloud_firestore/cloud_firestore.dart';
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
    List<String> serviceUrls = [];
    List<String> panoramas = [];

    final coverData = await FirebaseStorage.instance
        .ref('property/propertyData/$id/coverImage/')
        .putFile(property.coverImage);
    final coverUrl = await coverData.ref.getDownloadURL();
    /////////////////////////////////////////////////////////////////
    await Future.forEach(property.services, (element) async {
      final serviceData = await FirebaseStorage.instance
          .ref(
              'property/propertyData/$id/services/${DateTime.now().toIso8601String()}/')
          .putFile(element.image);
      final url = await serviceData.ref.getDownloadURL();
      serviceUrls.add(url);
    });
//////////////////////////////////////////////////////////////////

    if (property.panoramicView != null)
      await Future.forEach(property.panoramicView, (element) async {
        final panorama = await FirebaseStorage.instance
            .ref(
                'property/propertyData/$id/panorama/${DateTime.now().toIso8601String()}/')
            .putFile(element.image);
        final url = await panorama.ref.getDownloadURL();

        panoramas.add(url);
      });
/////////////////////////////////////////////////////////////////
    await Future.forEach(property.images, (element) async {
      final key = UniqueKey();

      final urlData = await FirebaseStorage.instance
          .ref('property/propertyData/$id/images/${key.toString()}}')
          .putFile(element);
      final url = await urlData.ref.getDownloadURL();
      imageUrls.add(url);
    }).then((_) => FirebaseFirestore.instance
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
          'rates': property.rates.toLowerCase(),
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
          'view360': List.generate(
              property.panoramicView.length,
              (i) => {
                    'hotspots': property.panoramicView[i].hotspots,
                    'id': DateTime.now().toIso8601String(),
                    'image': panoramas[i],
                    'name': property.panoramicView[i].name,
                  }),
          'services': List.generate(
              property.services.length,
              (index) => {
                    'category': property.propertyCategory,
                    'name': null,
                    'price': property.services[index].price,
                    'status': 'Available',
                    'imageUrl': serviceUrls[index]
                  })
        }));
    print('Property sent');

    notifyListeners();
  }
}
