import 'package:flutter/material.dart';
import 'package:flutter_kart/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Login",
          style: Constants.regularHeading,
        ),
      ),
    );
  }
}
