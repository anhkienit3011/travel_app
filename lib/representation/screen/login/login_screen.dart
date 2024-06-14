import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/extensions/validate.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/firebase_auth_impleentation/firebase_auth_services.dart';
import 'package:travel_app/representation/screen/login/signup_screen.dart';
import 'package:travel_app/representation/screen/main_app.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorPalette.primaryColor,
        elevation: 0,
      ),
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                  Icons.person,
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
                  "Sign in to continue.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                inputForm("Email", _emailController),
                SizedBox(height: 20),
                inputForm("Password", _passwordController),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: ColorPalette.primaryColor),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: _logIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      "Login",
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
                    Text("New User? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                      },
                      child: Text(
                        "Sign Up",
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
  void _logIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null){
      print("Login success");
      Navigator.pushReplacementNamed(context, MainApp.routeName);
    }else{
      print("Some error happend");
    }
  }
}

