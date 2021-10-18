import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/property_model.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/providers/location_provider.dart';
import 'package:travel_admin/screens/add_property/add_on_map.dart';
import 'package:travel_admin/screens/property_details/property_details_screen.dart';

class AddPropertyScreen extends StatefulWidget {
  static const routeName = '/add-property';
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  PropertyModel property;
  File coverFile;
  List<File> fileImages = [];
  String name;
  String coverImage;
  String description;
  String price;
  String category = 'Apartment';
  List<String> images;
  String town;

  String country;
  double longitude;
  double latitude;
  List<Offer> offers;
  List<String> ammenities;
  List<Media> mediaList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locData = Provider.of<LocationProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text('Add Property',
            style: TextStyle(color: kPrimary, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
//COVER IMAGE
            GestureDetector(
              onTap: () async => openImagePicker(context, true),
              child: Row(
                children: [
                  if (coverFile == null)
                    SizedBox(
                      width: 15,
                    ),
                  if (coverFile == null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: Column(
                        children: [
                          Icon(Icons.add),
                          Text(
                            'Cover Photo',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  if (coverFile != null)
                    Expanded(
                      child: Container(
                        height: size.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: coverFile == null
                            ? Center(
                                child: Text('Select the cover image'),
                              )
                            : Image.file(
                                coverFile,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                ],
              ),
            ),

            //PROPERTY NAME
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the name of the property';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Name of Property',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          name = text;
                        })
                      }),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the description';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Detailed description',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          description = text;
                        })
                      }),
            ),

            Container(
                //
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text('Select the category'),
                    isExpanded: true,
                    onChanged: (val) {
                      setState(() {
                        category = val;
                      });
                    },
                    value: category,
                    items: categories
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(fontSize: 15),
                              ),
                            ))
                        .toList(),
                  ),
                )),

            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.parse(val) < 1) {
                      return 'Please enter a valid price';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Average Price',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          price = text;
                        })
                      }),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the town/city';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Town/City',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          town = text;
                        })
                      }),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the country';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Country',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          country = text;
                        })
                      }),
            ),

            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter amenities';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText:
                          'Ammenities/Services (Separate each with a comma  ,)',
                      helperStyle: TextStyle(color: kPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimary, width: 1)),
                      border: InputBorder.none),
                  onChanged: (text) => {
                        setState(() {
                          ammenities = text.split(',');
                        })
                      }),
            ),
            Divider(),

            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    locData.longitude != null && locData.latitude != null
                        ? 'Selected at (${locData.latitude.toStringAsFixed(2)}, ${locData.longitude.toStringAsFixed(2)})'
                        : 'Select on map',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: locData.longitude != null &&
                                locData.latitude != null
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: locData.longitude != null &&
                                locData.latitude != null
                            ? Colors.green
                            : Colors.black),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.of(context)
                              .pushNamed(AddOnMap.routeName, arguments: {
                            'lat': latitude,
                            'lon': longitude,
                          }),
                      child: Icon(Icons.map))
                ],
              ),
            ),
            Divider(),

            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Add more photos',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),

            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () async => await openImagePicker(context, false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        margin: EdgeInsets.only(top: 15),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            Icon(Icons.add),
                            Text(
                              'Photos',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (fileImages != null)
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          children: List.generate(
                            fileImages.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              height: 120,
                              width: 130,
                              child: Image.file(
                                fileImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )),

            SizedBox(
              height: 30,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: size.width * 0.8,
              child: RaisedButton(
                color: ammenities != null &&
                        fileImages != null &&
                        coverFile != null &&
                        name != null &&
                        price != null &&
                        town != null &&
                        country != null &&
                        description != null &&
                        locData.latitude != null &&
                        locData.longitude != null
                    ? kPrimary
                    : Colors.grey,
                onPressed: () async {
                  final property = PropertyModel(
                      ammenities: ammenities,
                      ownerName: user.fullName,
                      reviews: null,
                      offers: null,
                      coverImage: coverFile,
                      images: fileImages,
                      ownerId: FirebaseAuth.instance.currentUser.uid,
                      description: description,
                      name: name,
                      price: price,
                      propertyCategory: category,
                      location: PropertyLocation(
                        latitude: locData.latitude,
                        longitude: locData.longitude,
                        country: country,
                        town: town,
                      ));

                  if (ammenities != null &&
                      fileImages != null &&
                      coverFile != null &&
                      name != null &&
                      price != null &&
                      town != null &&
                      country != null &&
                      description != null &&
                      locData.latitude != null &&
                      locData.longitude != null) {
                    Navigator.of(context).pushNamed(
                        PropertyDetailsScreen.routeName,
                        arguments: property);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Fill in all the fields'),
                    ));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Preview',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  List<String> categories = [
    'Apartment',
    'Hotel',
    'Cottage',
    'Bungalow',
    'Resort',
    'Villa',
  ];

  Future<void> openImagePicker(BuildContext context, bool isCover) async {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: controller,
                      mediaList: mediaList,
                      onPick: (selectedList) {
                        setState(() => mediaList = selectedList);
                        if (isCover) {
                          coverFile = mediaList.first.file;
                          mediaList.clear();
                        } else {
                          mediaList.forEach((element) {
                            fileImages.add(element.file);
                          });
                          mediaList.clear();
                        }
                        mediaList.clear();

                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount:
                          isCover ? MediaCount.single : MediaCount.multiple,
                      mediaType: MediaType.image,
                      decoration: PickerDecoration(
                        cancelIcon: Icon(Icons.close),
                        albumTitleStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        actionBarPosition: ActionBarPosition.top,
                        blurStrength: 2,
                        completeText: 'Change',
                      ),
                    )),
              ));
        });
  }

  void openMap(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                maxChildSize: 0.95,
                minChildSize: 0.8,
                builder: (ctx, controller) => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  color: Colors.white,
                  child: AddOnMap(),
                ),
              ));
        });
  }
}
