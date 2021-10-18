import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = 'loading_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Lottie.asset('assets/loading.json', fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
