import 'package:flutter/material.dart';
import 'package:triprex/facilities_page.dart';
import 'package:triprex/feedback_page.dart';
import 'package:triprex/login_page.dart';
import 'package:triprex/payment_page.dart';
import 'package:triprex/profile_page.dart';
import 'package:triprex/about_page.dart';
import 'package:triprex/AdminDashboard.dart';


class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('img2.png'), // Use your image path here
                  radius: 30,
                ),
                const SizedBox(width: 16),
                const Text('User Name'), // Replace with actual user name
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Admin'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard())), // Navigate to payment page
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), // Navigate to login page
          ),
          ListTile(
            leading: const Icon(Icons.visibility), // Consider using a more specific icon for profile
            title: const Text('Profile'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())), // Navigate to profile page
          ),
          ListTile(
            leading: const Icon(Icons.business_center), // Use a descriptive icon for about us
            title: const Text('About Us'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage())), // Navigate to about us page
          ),
          ListTile(
            leading: const Icon(Icons.business_center), // Use a descriptive icon for facilities
            title: const Text('Facilities'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage())), // Navigate to facilities page
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage())), // Navigate to feedback page
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage())), // Navigate to payment page
          ),
        ],
      ),
    );
  }
}
