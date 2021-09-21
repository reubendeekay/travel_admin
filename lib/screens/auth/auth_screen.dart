import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/bottom_nav.dart';
import 'package:travel_admin/constants.dart';

import 'package:travel_admin/providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email;
  String _password;
  String fullName;
  String phoneNumber;

  final _formKey = GlobalKey<FormState>();

  // bool isLogin = true;
  double opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              ///////////////LOTTIE ANIMATION///////////////////////////
              // Positioned(
              //   bottom: 10,
              //   left: 0,
              //   child: Container(
              //       height: size.height * 0.15,
              //       width: size.width * 0.14,
              //       child:
              //           Lottie.asset('assets/login.json', fit: BoxFit.cover)),
              // ),
              Positioned(
                  top: 0,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: Container(
                          height: size.height * 0.3,
                          width: size.width,
                          child: Lottie.asset('assets/bubble.json',
                              fit: BoxFit.cover)),
                    ),
                  )),

              /////////////START OF AUTH FORM/////////////

              SingleChildScrollView(
                child: Column(
                  children: [
                    AnimatedContainer(
                      height: size.height - MediaQuery.of(context).padding.top,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 1000),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.25,
                            ),
                            Text(
                              // isLogin ? 'Login' : 'Sign up',
                              'Admin Login',
                              style: GoogleFonts.roboto(
                                  fontSize: 36, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),

                            /////////////////////LOGIN FIELDS///////////////////////////
                            // if (!isLogin)
                            //   AnimatedOpacity(
                            //       curve: Curves.fastLinearToSlowEaseIn,
                            //       opacity: isLogin ? 0 : 1,
                            //       duration: Duration(milliseconds: 1000),
                            //       child: Container(
                            //         height: 50,
                            //         width: double.infinity,
                            //         margin: EdgeInsets.symmetric(
                            //             horizontal: 15, vertical: 10),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Colors.grey[300]),
                            //         child: TextFormField(
                            //             validator: (val) {
                            //               if (val.isEmpty) {
                            //                 return 'Please enter your full name';
                            //               }
                            //               return null;
                            //             },
                            //             decoration: InputDecoration(
                            //                 contentPadding:
                            //                     EdgeInsets.symmetric(horizontal: 15),
                            //                 labelText: 'Full name',
                            //                 helperStyle: TextStyle(color: kPrimary),
                            //                 focusedBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     borderSide: BorderSide(
                            //                         color: kPrimary, width: 1)),
                            //                 border: InputBorder.none),
                            //             onChanged: (text) => {
                            //                   setState(() {
                            //                     fullName = text;
                            //                   })
                            //                 }),
                            //       )),

                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300]),
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    if (!val.contains('@') ||
                                        !val.contains('.')) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      labelText: 'Email address',
                                      helperStyle: TextStyle(color: kPrimary),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: kPrimary, width: 1)),
                                      border: InputBorder.none),
                                  onChanged: (text) => {
                                        setState(() {
                                          _email = text;
                                        })
                                      }),
                            ),

                            // if (!isLogin)
                            //   AnimatedOpacity(
                            //       curve: Curves.fastLinearToSlowEaseIn,
                            //       opacity: isLogin ? 0 : 1,
                            //       duration: Duration(milliseconds: 1000),
                            //       child: Container(
                            //         height: 50,
                            //         width: double.infinity,
                            //         margin: EdgeInsets.symmetric(
                            //             horizontal: 15, vertical: 10),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Colors.grey[300]),
                            //         child: TextFormField(
                            //             validator: (val) {
                            //               if (val.isEmpty) {
                            //                 return 'Please enter your phone number';
                            //               }
                            //               if (val.length < 7) {
                            //                 return 'Enter a valid phone number';
                            //               }
                            //               return null;
                            //             },
                            //             decoration: InputDecoration(
                            //                 contentPadding:
                            //                     EdgeInsets.symmetric(horizontal: 15),
                            //                 labelText: 'Phone number',
                            //                 helperStyle: TextStyle(color: kPrimary),
                            //                 focusedBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     borderSide: BorderSide(
                            //                         color: kPrimary, width: 1)),
                            //                 border: InputBorder.none),
                            //             onChanged: (text) => {
                            //                   setState(() {
                            //                     phoneNumber = text;
                            //                   })
                            //                 }),
                            //       )),
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
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
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      labelText: 'Password',
                                      helperStyle: TextStyle(color: kPrimary),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: kPrimary, width: 1)),
                                      border: InputBorder.none),
                                  onChanged: (text) => {
                                        setState(() {
                                          _password = text;
                                        })
                                      }),
                            ),
                            //////////////////////////////////////////////////////////////////////////////////////////////////
                            ///
                            ///
                            // /
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Forgot password?'),
                                SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: kPrimary,
                                onPressed: () async {
                                  // Navigator.of(context).pushReplacementNamed(
                                  //   MainDrawer.routeName,
                                  // );
                                  await trySubmit();
                                },
                                child: Text(
                                  // isLogin ? 'Sign in' : 'Sign up',
                                  'Sign in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: Text(
                                  'Only authorized personell are allowed to login. Frequent audits are done to ensure use of roles responsibly. Terms and Conditions for use apply.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(isLogin
                            //         ? 'Dont have an account?'
                            //         : 'Already have an account?'),
                            //     TextButton(
                            //       onPressed: () {
                            //         setState(() {
                            //           isLogin = !isLogin;
                            //         });
                            //       },
                            //       child: Text(
                            //         isLogin ? 'Register' : 'Sign in',
                            //         style: TextStyle(
                            //             color: kPrimary, fontWeight: FontWeight.w600),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> trySubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // if (isLogin) {
      Provider.of<AuthProvider>(context, listen: false)
          .login(email: _email.trim(), password: _password.trim())
          .then((data) async {
        Navigator.of(context).pushReplacementNamed(MyNav.routeName);
        await Provider.of<AuthProvider>(context, listen: false)
            .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
      });
      // } else {
      //   await Provider.of<AuthProvider>(context, listen: false)
      //       .signUp(
      //     email: _email.trim(),
      //     fullName: fullName,
      //     password: _password.trim(),
      //     phoneNumber: phoneNumber.trim(),
      //   )
      //       .then((_) async {
      //     // Navigator.of(context).pushReplacementNamed(Home.routeName);
      //     await Provider.of<AuthProvider>(context, listen: false)
      //         .getCurrentUser(FirebaseAuth.instance.currentUser.uid);
      //   });
      // }
    }
  }

  // Widget inputCard({@required String title, String variable}) {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
  //     child: TextFormField(
  //         decoration: InputDecoration(
  //             contentPadding: EdgeInsets.symmetric(horizontal: 15),
  //             labelText: title,
  //             helperStyle: TextStyle(color: kPrimary),
  //             focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //                 borderSide: BorderSide(color: kPrimary, width: 1)),
  //             border: InputBorder.none),
  //         onChanged: (text) => {
  //               setState(() {
  //                 variable = text;
  //               })
  //             }),
  //   );
  // }
}
