import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/screens/add_property/add_property.dart';
import 'package:travel_admin/screens/home/widgets/home_top.dart';
import 'package:travel_admin/screens/manage_property/properties.dart';

class ManagePropertyScreen extends StatelessWidget {
  static const routeName = '/manage-property';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ManagePropertyOption(
                  color: Colors.green,
                  icon: Icons.add,
                  title: 'New',
                  routeName: AddPropertyScreen.routeName,
                ),
                ManagePropertyOption(
                  color: Colors.blue,
                  icon: Icons.graphic_eq,
                  title: 'Analytics',
                  routeName: AddPropertyScreen.routeName,
                ),
                ManagePropertyOption(
                  color: Colors.red,
                  icon: Icons.add,
                  title: 'Add Property',
                  routeName: AddPropertyScreen.routeName,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: ListView(
              children: [
                AllProperty(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ManagePropertyOption extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String routeName;

  const ManagePropertyOption(
      {Key key, this.color, this.title, this.icon, this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: color,
              child: Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ),
            if (title != null)
              SizedBox(
                height: 1,
              ),
            if (title != null)
              Container(
                child: FittedBox(
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[800], fontSize: 13)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
