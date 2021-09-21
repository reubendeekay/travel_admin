import 'package:flutter/material.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/screens/add_property/add_property.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: kPrimary,
          onPressed: () =>
              Navigator.of(context).pushNamed(AddPropertyScreen.routeName),
          child: Text('Add Property', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
