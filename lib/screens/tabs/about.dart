import 'package:flutter/material.dart';
import 'package:women_safety/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class Abouttab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            context.signOut();
            Navigator.of(context).push(AuthScreen.route);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
