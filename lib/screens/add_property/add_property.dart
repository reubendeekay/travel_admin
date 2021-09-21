import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/models/property_model.dart';

class AddPropertyScreen extends StatefulWidget {
  static const routeName = '/add-property';
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  PropertyModel property;
  File coverFile;
  List<File> fileImages;
  String name;
  String coverImage;
  String description;
  String price;
  String category;
  List<String> images;
  PropertyLocation location;
  List<Offer> offers;
  List<String> ammenities;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text('Add Property', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
//COVER IMAGE
            Container(
              height: size.width * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: coverFile == null
                  ? Center(
                      child: Text('Select the cover image'),
                    )
                  : Image.file(
                      coverFile,
                      fit: BoxFit.cover,
                    ),
            ),

            //PROPERTY NAME
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (val.length < 6) {
                      return 'Password should have atleast 6 characters';
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
          ],
        ),
      ),
    );
  }
}
