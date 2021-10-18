import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/location_provider.dart';
import 'package:travel_admin/screens/add_property/add_property.dart';
import 'package:travel_admin/screens/home/widgets/home_action_tile.dart';
import 'package:travel_admin/screens/home/widgets/home_top.dart';
import 'package:travel_admin/screens/manage_property/manage_property_screen.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<LocationProvider>(context).getCurrentLocation();
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeTop(),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
