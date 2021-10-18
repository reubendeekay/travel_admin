import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_admin/constants.dart';

class HomeActionTile extends StatelessWidget {
  final String title;
  final int number;
  final String routeName;
  final bool isActive;
  HomeActionTile({this.title, this.number, this.routeName, this.isActive});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? kPrimary : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 1,
              )
            ]),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Text('$number',
                  style: GoogleFonts.notoSans(
                      color: isActive
                          ? Colors.grey[200].withOpacity(0.5)
                          : kPrimary.withOpacity(0.1),
                      fontSize: 70,
                      fontWeight: FontWeight.w900)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$number',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : kPrimary),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : kPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
