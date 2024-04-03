import 'package:flutter/material.dart';
import '../../../controller/firebase.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class InsertForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyFormWidget(),
    );
  }
}

class MyFormWidget extends StatefulWidget {
  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Navigate to a screen for email/password sign in
            },
            child: Text('Sign in with email/password'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to a screen for registration
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
