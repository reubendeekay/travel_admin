import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/screens/chat/chat_screen.dart';
import 'package:travel_admin/screens/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNav extends StatefulWidget {
  static const routeName = '/my-nav';

  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context)
        .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: kPrimary,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.grey,
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  // iconSize: 26,
                ),
                GButton(
                  icon: FontAwesomeIcons.addressBook,
                  text: 'Bookings',
                ),
                GButton(
                  icon: FontAwesomeIcons.comment,
                  text: 'Chat',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  List _screens = [
    Home(),
    Home(),
    ChatScreen(),
    Home(),
  ];
}
