import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Initial values
  final _firstNameController = TextEditingController(text: 'Aman');
  final _lastNameController = TextEditingController(text: 'Kumar Singh');
  final _mobileNumberController = TextEditingController(text: '1234567890');
  final _emailController = TextEditingController(text: 'amankumarsingh@example.com');
  final _passwordController = TextEditingController(text: '');
  final _addressController = TextEditingController(text: '123 Main St, Hometown');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('img2.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 10),
                Text(''),
                const SizedBox(height: 20),
                _buildTextField('First Name', Icons.person, _firstNameController),
                const SizedBox(height: 20),
                _buildTextField('Last Name', Icons.person, _lastNameController),
                const SizedBox(height: 20),
                _buildTextField('Mobile Number', Icons.phone, _mobileNumberController),
                const SizedBox(height: 20),
                _buildTextField('Email', Icons.email, _emailController),
                const SizedBox(height: 20),
                _buildTextField('Password', Icons.lock, _passwordController, obscureText: true),
                const SizedBox(height: 20),
                _buildTextField('Address', Icons.home, _addressController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Profile Updated Successfully!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) return 'Please enter your $label';
        return null;
      },
    );
  }
}
