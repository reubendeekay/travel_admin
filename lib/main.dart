import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/bottom_nav.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/providers/chat_provider.dart';
import 'package:travel_admin/providers/location_provider.dart';
import 'package:travel_admin/providers/property_provider.dart';
import 'package:travel_admin/screens/add_property/add_on_map.dart';
import 'package:travel_admin/screens/add_property/add_property.dart';
import 'package:travel_admin/screens/auth/auth_screen.dart';
import 'package:travel_admin/screens/auth/widgets/loading_screen.dart';
import 'package:travel_admin/screens/chat/chat_room.dart';
import 'package:travel_admin/screens/chat/chat_screen_search.dart';
import 'package:travel_admin/screens/home.dart';
import 'package:travel_admin/screens/manage_property/manage_property_screen.dart';
import 'package:travel_admin/screens/property_details/property_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimary,
          textTheme: GoogleFonts.barlowTextTheme(),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) => snapshot.hasData ? MyNav() : AuthScreen(),
        ),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          Home.routeName: (context) => Home(),
          AddPropertyScreen.routeName: (context) => AddPropertyScreen(),
          AddOnMap.routeName: (context) => AddOnMap(),
          LoadingScreen.routeName: (context) => LoadingScreen(),
          PropertyDetailsScreen.routeName: (context) => PropertyDetailsScreen(),
          ManagePropertyScreen.routeName: (context) => ManagePropertyScreen(),
          ChatRoom.routeName: (context) => ChatRoom(),
          ChatScreenSearch.routeName: (context) => ChatScreenSearch(),
        },
      ),
    );
  }
}
