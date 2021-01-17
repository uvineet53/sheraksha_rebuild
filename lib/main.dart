import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/services/authentication_service.dart';
import 'package:women_safety/screens/home.dart';
import 'package:women_safety/screens/sign_in.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<KUser>.value(
      value: Auth().user,
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KUser user = Provider.of<KUser>(context);
    if (user != null) {
      return HomeScreen();
    } else if (user == null) {
      return SignInForm();
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
