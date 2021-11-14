import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_crop/image_crop.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/property_model.dart';
import 'package:travel_admin/models/service_model.dart';
import 'package:travel_admin/models/view360_model.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/providers/location_provider.dart';
import 'package:travel_admin/screens/add_property/add_ammenities.dart';
import 'package:travel_admin/screens/add_property/add_on_map.dart';
import 'package:travel_admin/screens/add_property/add_service.dart';
import 'package:travel_admin/screens/property_review_details/property_details_screen.dart';

class AddPropertyScreen extends StatefulWidget {
  static const routeName = '/add-property';
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final cropKey = GlobalKey<CropState>();
  PropertyModel property;
  File coverFile;
  List<File> fileImages = [];
  List<File> view360Images = [];
  String name;
  String coverImage;
  String description;
  String price;
  String category;
  String rate;
  List<String> images;
  String town;

  String country;
  double longitude;
  double latitude;
  List<Offer> offers;
  List<String> ammenities = [];
  List<Media> mediaList = [];
  List<ServiceModel> services = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locData = Provider.of<LocationProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: Text('ADD TRAVELY',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
//COVER IMAGE
            GestureDetector(
              onTap: () async => openImagePicker(context, true),
              child: Container(
                height: size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: coverFile == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,
                                size: 24, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              'Select the cover image',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : Image.file(
                        coverFile,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            //PROPERTY NAME
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the name of the travely';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Name of travely',
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text('Select the rates'),
                    isExpanded: true,
                    onChanged: (val) {
                      setState(() {
                        rate = val;
                      });
                    },
                    value: rate,
                    items: rates
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
                //
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      labelText: 'Average Price in USD (\$)',
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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

            GestureDetector(
              onTap: () {
                Get.to(() => AddAmmenities(
                      onComplete: (val) {
                        setState(() {
                          ammenities = val;
                        });
                      },
                    ));
              },
              child: Container(
                  height: 48,
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ammenities.isEmpty
                        ? 'Key features'
                        : '${ammenities.length} feature(s)',
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => AddServices(
                      onCompleted: (val) {
                        setState(() {
                          services = val;
                        });
                      },
                    ));
              },
              child: Container(
                  height: 48,
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    services.isEmpty
                        ? 'Detailed Services'
                        : '${services.length} service(s)',
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  )),
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              height: 15,
            ),

            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                '360 Viewing Experience',
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
                    onTap: () async {
                      openImagePicker(context, false, is360: 'yes');
                    },
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
                            '360 View',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (view360Images != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        children: List.generate(
                          view360Images.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            height: 120,
                            width: 130,
                            child: Image.file(
                              view360Images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: size.width * 0.8,
              height: 45,
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
                    panoramicView: view360Images
                        .map((e) => View360Model(image: e))
                        .toList(),
                    services: services,
                    reviews: null,
                    offers: null,
                    rates: rate,
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
                    ),
                  );

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
                        PropertyReviewDetailsScreen.routeName,
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
    'Activity',
    'Hotel',
    'Restaurant',
    'Residence',
    'Event',
    'Flight',
    'Transport',
    'Shopping',
  ];
  List<String> rates = [
    'Per table',
    'Per person',
    'Per hour',
    'Per day',
    'Per night',
    'Per week',
    'Per month',
    'Per year',
  ];

  Future<void> openImagePicker(BuildContext context, bool isCover,
      {String is360}) async {
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
                        if (is360 != null) {
                          mediaList.forEach((element) {
                            view360Images.add(element.file);
                          });
                          mediaList.clear();
                        }
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
