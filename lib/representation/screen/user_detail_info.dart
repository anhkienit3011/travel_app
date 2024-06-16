import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/core/constants/color_constants.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/user_info_screen';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.email != null) {
        String userEmail = currentUser.email!;

        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs.first;
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          setState(() {
            _firstNameController.text = userData['first_name'] ?? '';
            _lastNameController.text = userData['last_name'] ?? '';
            _emailController.text = userData['email'] ?? '';
            _phoneController.text = userData['phone_number'] ?? '';
            _addressController.text = userData['address'] ?? '';
          });
        } else {
          print('No user found with this email');
        }
      } else {
        print('No user currently logged in');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? currentUser = _auth.currentUser;
        if (currentUser != null && currentUser.email != null) {
          String userEmail = currentUser.email!;

          QuerySnapshot querySnapshot = await _firestore
              .collection('users')
              .where('email', isEqualTo: userEmail)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            String docId = querySnapshot.docs.first.id;
            await _firestore.collection('users').doc(docId).update({
              'first_name': _firstNameController.text,
              'last_name': _lastNameController.text,
              'email': _emailController.text,
              'phone_number': _phoneController.text,
              'address': _addressController.text,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User information updated successfully')),
            );
          } else {
            print('No user found with this email');
          }
        } else {
          print('No user currently logged in');
        }
      } catch (e) {
        print('Error saving user info: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user information')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail Information'),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('First Name', _firstNameController, Icons.person),
                SizedBox(height: 20),
                _buildTextField('Last Name', _lastNameController, Icons.person),
                SizedBox(height: 16),
                _buildTextField('Email', _emailController, Icons.email),
                SizedBox(height: 16),
                _buildTextField('Phone', _phoneController, Icons.phone),
                SizedBox(height: 16),
                _buildTextField('Address', _addressController, Icons.home),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveUserInfo,
                    child: Text('Save Information'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}