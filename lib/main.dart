import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:triprex/AdminDashboard.dart';
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
    options: FirebaseOptions(
    apiKey: 'AIzaSyDkWBp0PVUZLzCvOQ0hT8YyAyNkrfRhOoI',
    appId: '1:765835812353:android:78326e198582a4c79a2a00',
    messagingSenderId: 'mp51gJDNIEhNMOLfMqGe',
    projectId: 'triprex-9c351',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripRex',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(156, 7, 10, 155),
      ),
      home: const LogoPage(), // Initial page can be changed based on your app flow
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/contact': (context) => const ContactPage(),
        '/feedback': (context) => FeedbackPage(),
        '/aboutUs': (context) => const AboutPage(),
        '/bookFlight': (context) => const BookFlightPage(tourName: '',),
        '/facilities': (context) => const FacilitiesPage(),
        '/payment': (context) => PaymentPage(),
        '/tour': (context) => const TourPage(),
        '/search': (context) => const SearchPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) =>  ProfilePage(),
        '/admindashboard': (context) =>  AdminDashboard(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
