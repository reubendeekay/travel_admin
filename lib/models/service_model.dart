import 'dart:io';

class ServiceModel {
  String imageUrl;
  File image;
  String status;
  double price;
  String name;
  String category;

  ServiceModel(
      {this.imageUrl,
      this.image,
      this.status,
      this.price,
      this.name,
      this.category});
}
