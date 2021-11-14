import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/helpers/service_tile_shimmer.dart';
import 'package:travel_admin/models/service_model.dart';
import 'package:travel_admin/screens/add_property/service_tile.dart';

class AddServices extends StatefulWidget {
  final Function(List<ServiceModel> services) onCompleted;
  AddServices({this.onCompleted});

  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  final _formKey = GlobalKey<FormState>();
  List<ServiceModel> services = [];
  int servicesLength = 1;
  List<Media> mediaList = [];
  File image;
  String name;
  String price;
  final priceController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services/Offers'.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Text(
                'Preview',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            ...List.generate(
              services.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Stack(
                  children: [
                    ServiceTile(services[index]),
                    Positioned(
                        right: 10,
                        top: 5,
                        child: GestureDetector(
                            onTap: () {
                              services.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(Icons.close)))
                  ],
                ),
              ),
            ),
            if (services.length == 0)
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: ServiceTileShimmer()),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Text(
                'Add Services/Offers',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              openImagePicker(context);
                            },
                            child: Container(
                              height: 70,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (image != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 70,
                              width: 80,
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                            )
                        ],
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        child: TextFormField(
                            controller: nameController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter the name of the service';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Name of service',
                                helperStyle: TextStyle(color: kPrimary),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: kPrimary, width: 1)),
                                border: InputBorder.none),
                            onChanged: (text) => {
                                  setState(() {
                                    name = text;
                                  })
                                }),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        child: TextFormField(
                            controller: priceController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter the price of the service';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                labelText: 'Price',
                                helperStyle: TextStyle(color: kPrimary),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: kPrimary, width: 1)),
                                border: InputBorder.none),
                            onEditingComplete: () {
                              services.add(ServiceModel(
                                image: image,
                                name: name,
                                price: double.parse(price),
                              ));
                            },
                            onChanged: (text) => {
                                  setState(() {
                                    price = text;
                                  })
                                }),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ])),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    services.add(ServiceModel(
                        price: double.parse(price), image: image, name: name));
                    price = null;
                    image = null;
                    name = null;
                    priceController.clear();
                    nameController.clear();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: kPrimary,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  widget.onCompleted(services);
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: kPrimary,
                child: Text(
                  'Complete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> openImagePicker(
    BuildContext context,
  ) async {
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

                        image = mediaList.first.file;
                        mediaList.clear();

                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.single,
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
}
