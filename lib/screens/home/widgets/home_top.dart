import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/screens/manage_property/manage_property_screen.dart';

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) => Container(
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: auth.user.imageUrl != null
                            ? NetworkImage(auth.user.imageUrl)
                            : AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.grey[800],
                    ),
                    onPressed: () {},
                  ),
                  Icon(
                    Icons.call_made_outlined,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Center(
                child: Column(
              children: [
                Text(
                  'BALANCE',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'KSH. 625.00',
                  style: TextStyle(fontSize: 24),
                )
              ],
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopOption(
                  color: Colors.green,
                  icon: Icons.dashboard_customize,
                  title: 'Manage\nProperty',
                  routeName: ManagePropertyScreen.routeName,
                ),
                HomeTopOption(
                  color: Colors.blue,
                  icon: Icons.near_me,
                  title: 'Media',
                ),
                HomeTopOption(
                  color: Colors.red,
                  icon: Icons.clear_all_sharp,
                  title: 'Manage\nBookings',
                ),
                HomeTopOption(
                  color: Colors.orange,
                  icon: Icons.person_search_rounded,
                  title: 'Manage\nUsers',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeTopOption extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String routeName;

  const HomeTopOption(
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
              radius: 22,
              backgroundColor: color,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            if (title != null)
              SizedBox(
                height: 5,
              ),
            if (title != null)
              Container(
                child: FittedBox(
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[800])),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
