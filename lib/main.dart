import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/constants.dart';
import 'package:travel_admin/helpers/push_notifications.dart';
import 'package:travel_admin/providers/auth_provider.dart';
import 'package:travel_admin/providers/chat_provider.dart';
import 'package:travel_admin/providers/location_provider.dart';
import 'package:travel_admin/providers/property_provider.dart';
import 'package:travel_admin/screens/add_property/add_on_map.dart';
import 'package:travel_admin/screens/add_property/add_property.dart';
import 'package:travel_admin/screens/auth/auth_screen.dart';
import 'package:travel_admin/screens/auth/widgets/loading_screen.dart';
import 'package:travel_admin/screens/chat/chat_room.dart';
import 'package:travel_admin/screens/chat/chat_screen.dart';
import 'package:travel_admin/screens/chat/chat_screen_search.dart';
import 'package:travel_admin/screens/home.dart';
import 'package:travel_admin/screens/manage_property/analytics_screen.dart';
import 'package:travel_admin/screens/manage_property/manage_property_screen.dart';
import 'package:travel_admin/screens/media/add_ad.dart';
import 'package:travel_admin/screens/property_details/property_details_screen.dart';
import 'package:travel_admin/screens/property_review_details/property_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF884DFF),
            ledColor: kPrimary)
      ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    registerNotification();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      // your page params. I recommend to you to pass all *receivedNotification* object
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimary, textTheme: GoogleFonts.openSansTextTheme()),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) => snapshot.hasData ? Home() : AuthScreen(),
        ),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          Home.routeName: (context) => Home(),
          AddPropertyScreen.routeName: (context) => AddPropertyScreen(),
          AddOnMap.routeName: (context) => AddOnMap(),
          LoadingScreen.routeName: (context) => LoadingScreen(),
          PropertyReviewDetailsScreen.routeName: (context) =>
              PropertyReviewDetailsScreen(),
          ManagePropertyScreen.routeName: (context) => ManagePropertyScreen(),
          ChatRoom.routeName: (context) => ChatRoom(),
          ChatScreenSearch.routeName: (context) => ChatScreenSearch(),
          PropertyDetailsScreen.routeName: (context) => PropertyDetailsScreen(),
          AddAdScreen.routeName: (context) => AddAdScreen(),
          AnalyticsScreen.routeName: (context) => AnalyticsScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
        },
      ),
    );
  }
}
