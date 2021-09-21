import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/screens/home.dart';

class MyNav extends StatefulWidget {
  static const routeName = '/my-nav';
  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  var _selectedTab = 0;
  Widget _currentScreen;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            if (_selectedTab != 0) {
              setState(() {
                _selectedTab = 0;
              });
            } else {
              Navigator.of(context).pop();
            }

            return false;
          },
          child: BottomBarPageTransition(
            builder: (_, index) => _screens[index],
            currentIndex: _selectedTab,
            totalLength: _screens.length,
            transitionType: TransitionType.circular,
            transitionDuration: Duration(milliseconds: 1000),
            transitionCurve: Curves.ease,
          )),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: DotNavigationBar(
          marginR: const EdgeInsets.all(10),
          paddingR: const EdgeInsets.all(3),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              blurRadius: 1,
            )
          ],
          margin: const EdgeInsets.only(left: 5, right: 5),
          selectedItemColor: kPrimary,
          currentIndex: _selectedTab,
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(
                Icons.location_on,
                size: 30,
              ),
            ),

            /// Search
            DotNavigationBarItem(
              icon: const FaIcon(
                FontAwesomeIcons.solidComment,
                size: 26,
              ),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: const FaIcon(
                Icons.settings,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List _screens = [
  Home(),
  Home(),
  Home(),
  Home(),
  Home(),
];
