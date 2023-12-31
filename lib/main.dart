import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_mobileapps/pages/BookingPage.dart';
import 'package:rent_mobileapps/pages/DashboardPage.dart';
import 'package:rent_mobileapps/pages/EditProfilePage.dart';
import 'package:rent_mobileapps/pages/HistoryPage.dart';
import 'package:rent_mobileapps/pages/LoginPage.dart';
import 'package:rent_mobileapps/pages/SignupPage.dart';
import 'package:rent_mobileapps/pages/DetailStudioPage.dart';
import 'package:rent_mobileapps/pages/ReviewPage.dart';
import 'package:rent_mobileapps/pages/CreateReviewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLogin = await prefs.getBool('isLogin');
  runApp(MyApp(
    status: isLogin ?? false,
  ));
}

class MyApp extends StatelessWidget {
  final bool status;
  const MyApp({required this.status});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        '/': (context) => DashboardPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/studio': (context) => DetailStudioPage(),
        '/booking': (context) => BookingPage(),
        '/history': (context) => HistoryPage(),
        '/review': (context) => ReviewPage(),
        '/createreview': (context) => CreateReviewPage(),
        '/profile': (context) => EditProfilePage()
      },
      initialRoute: status ? '/' : '/login',
      title: 'Flutter Demo',
    );
  }
}
