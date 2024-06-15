import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/extensions/validate.dart';

import 'package:travel_app/firebase_auth_impleentation/firebase_auth_services.dart';
import 'package:travel_app/representation/screen/main_app.dart';


import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorPalette.primaryColor,
        elevation: 0,
      ),
      body: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();



  bool _isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: ColorPalette.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(60, 60),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.person_add,
                  size: 50,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Sign up to get started.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                inputForm("Email", _emailController),
                SizedBox(height: 20),
                inputForm("Password", _passwordController),
                SizedBox(height: 20),
                inputForm("Confirm Password", _confirmPasswordController),
                SizedBox(height: 50),
                inputForm("First Name", _firstNameController),
                SizedBox(height: 20),
                inputForm("Last Name", _lastNameController),
                SizedBox(height: 20),
                inputForm("Date of Bith", _DOBController),
                SizedBox(height: 20),
                inputForm("Address", _addressController),
                SizedBox(height: 20),
                inputForm("Phone number", _phoneNumberController),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: ColorPalette.primaryColor),
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputForm(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: title == "Email"
                ? Border.all(
                width: 0.5,
                color: controller.text.isEmpty
                    ? Colors.grey
                    : _isEmailValid
                    ? Colors.green
                    : Colors.red)
                : Border.all(width: 0.5, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: (value) {
                if (title == "Email") {
                  if (value.isEmpty) {
                    setState(() {
                      _isEmailValid = true;
                    });
                  } else {
                    final isValid = validateEmailAddress(value);
                    if (isValid) {
                      setState(() {
                        _isEmailValid = true;
                      });
                    } else {
                      setState(() {
                        _isEmailValid = false;
                      });
                    }
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String enteredConfirmPassword = _confirmPasswordController.text;

    if( password == enteredConfirmPassword){
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        //Timestamp.fromDate(DateTime.parse(_DOBController.text)),
        _addressController.text.trim(),
        _phoneNumberController.text.trim(),


      );

      if (user != null){
        print("Sign Up success");
        Navigator.pushReplacementNamed(context, MainApp.routeName);
      }else{
        print("Some error happend");
      }
    }
    else{
      // Show an error message for mismatched password and confirm password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password and confirm password do not match'),
          duration: Duration(seconds: 2),
        ),
      );

    }
    // add user details



  }
  Future addUserDetails(
      String first_name,String last_name, String address, String phone_number
      ) async{
    await FirebaseFirestore.instance.collection('users').add({
      'first_name': first_name,
      'last_name': last_name,
      //'date_of_birth':date_of_birth,
      'address':address,
      'phone_number':phone_number,
      //'create_at' : Timestamp.fromDate(DateTime.now()),

    });
  }
}
