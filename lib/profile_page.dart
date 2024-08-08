import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc('userId') // Use actual user ID
          .get();

      if (userProfile.exists) {
        _firstNameController.text = userProfile['firstName'];
        _lastNameController.text = userProfile['lastName'];
        _mobileNumberController.text = userProfile['mobileNumber'];
        _emailController.text = userProfile['email'];
        _passwordController.text = userProfile['password'];
        _addressController.text = userProfile['address'];
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await FirebaseFirestore.instance.collection('profiles').doc('profileId').set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'mobileNumber': _mobileNumberController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'address': _addressController.text,
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Profile Updated'),
            content: Text('Your profile has been updated successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(color: Color.fromRGBO(245, 234, 76, 1)),
        ),
        backgroundColor: Color.fromARGB(255, 118, 89, 223),
        actions: [
          TextButton(
            onPressed: () {
              // Add your manage account logic here
            },
            child: Text(
              'Manage Account',
              style: TextStyle(color: Color.fromRGBO(245, 234, 76, 1)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('img2.png'),
              ),
              SizedBox(height: 10),
              Text(
                'User Name', // Placeholder text
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildProfileField('First Name', _firstNameController),
              buildProfileField('Last Name', _lastNameController),
              buildProfileField('Mobile Number', _mobileNumberController, isButton: true),
              buildProfileField('Email', _emailController, isButton: true, hasDelete: true),
              buildProfileField('Password', _passwordController, isPassword: true),
              buildProfileField('Address', _addressController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUserProfile,
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileField(String label, TextEditingController controller,
      {bool isButton = false, bool hasDelete = false, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          if (isButton) ...[
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Add your logic for Add button here
              },
              child: Text('Add'),
            ),
            if (hasDelete) ...[
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Add your logic for Delete button here
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
