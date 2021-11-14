import 'dart:io';

import 'package:travel_admin/models/service_model.dart';
import 'package:travel_admin/models/view360_model.dart';

class PropertyModel {
  final String name;
  final String id;
  final List<File> images;
  final List<dynamic> imageUrls;
  final File coverImage;
  final String coverImageString;
  final String description;
  final String price;
  final String rates;
  final PropertyLocation location;
  final List<dynamic> ammenities;
  final String ownerName;
  final String ownerId;
  final List<dynamic> reviews;
  final List<dynamic> offers;
  final String propertyCategory;
  final double rating;
  final int views;
  final List<ServiceModel> services;
  final List<View360Model> panoramicView;

  const PropertyModel(
      {this.name,
      this.id,
      this.coverImage,
      this.images,
      this.description,
      this.price,
      this.location,
      this.ammenities,
      this.ownerName,
      this.rates,
      this.ownerId,
      this.reviews,
      this.offers,
      this.propertyCategory,
      this.coverImageString,
      this.imageUrls,
      this.rating,
      this.views,
      this.panoramicView,
      this.services});
}

class PropertyLocation {
  final double latitude;
  final double longitude;
  final String town;
  final String country;

  const PropertyLocation({
    this.latitude,
    this.longitude,
    this.country,
    this.town,
  });

  Map<String, Object> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'town': town,
    };
  }
}

class ReviewModel {
  final String nameOfReviewer;
  final double rating;
  final String review;
  final DateTime dateReviewed;
  final String profilePic;

  ReviewModel(
      {this.nameOfReviewer,
      this.rating,
      this.review,
      this.dateReviewed,
      this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      'nameOfReviewer': nameOfReviewer,
      'rating': rating,
      'review': review,
      'dateReviewed': dateReviewed,
      'profilePic': profilePic
    };
  }
}

class Offer {
  final String offerTitle;
  final double discount;
  final double price;

  Offer({this.offerTitle, this.discount, this.price});

  Map<String, dynamic> toJson() {
    return {
      'offerTitle': offerTitle,
      'discount': discount,
      'price': price,
    };
  }
}
