import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:travel_admin/providers/auth_provider.dart';

import 'package:travel_admin/screens/home/widgets/home_top.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<AuthProvider>(context)
        .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
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
