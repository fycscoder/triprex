import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(child: Text('Welcome to Admin Dashboard')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/aboutUs');
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Bookings'),
              onTap: () {
                Navigator.pushNamed(context, '/bookings');
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              title: Text('Book Flight'),
              onTap: () {
                Navigator.pushNamed(context, '/bookFlight');
              },
            ),
            ListTile(
              title: Text('Facilities'),
              onTap: () {
                Navigator.pushNamed(context, '/facilities');
              },
            ),
            ListTile(
              title: Text('Payment'),
              onTap: () {
                Navigator.pushNamed(context, '/payment');
              },
            ),
            ListTile(
              title: Text('Tour'),
              onTap: () {
                Navigator.pushNamed(context, '/tour');
              },
            ),
            ListTile(
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            

          ],
        ),
      ),
    );
  }
}
