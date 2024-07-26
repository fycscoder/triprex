import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:triprex/AdminDashboard.dart';
import 'package:triprex/firebase_options.dart';
import 'package:triprex/logo_page.dart';
import 'package:triprex/login_page.dart';       
import 'package:triprex/signup_page.dart';      
import 'package:triprex/contact_page.dart';   
import 'package:triprex/book_flight_page.dart';
import 'package:triprex/feedback_page.dart';
import 'package:triprex/about_page.dart';
import 'package:triprex/facilities_page.dart';
import 'package:triprex/payment_page.dart';
import 'package:triprex/tour_page.dart';
import 'package:triprex/search_page.dart';
import 'package:triprex/home_page.dart';
import 'package:triprex/profile_page.dart'; 
  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripRex',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(156, 7, 10, 155),
      ),
      home: const LogoPage(), // Home page can be changed based on your navigation flow
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/contact': (context) => const ContactPage(),
        '/feedback': (context) => FeedbackPage(),
        '/aboutUs': (context) => AboutPage(),
        '/bookFlight': (context) => BookFlightPage(),
        '/facilities': (context) => FacilitiesPage(),
        '/payment': (context) => PaymentPage(),
        '/tour': (context) => TourPage(),
        '/search': (context) => SearchPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/admindashboard': (context) => AdminDashboard(),
        
      },
      
      debugShowCheckedModeBanner: false,
    );
  }
}
