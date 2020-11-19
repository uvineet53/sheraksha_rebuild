import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:women_safety/screens/onboarding/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for Firebase core
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return LitAuthInit(
            authProviders: const AuthProviders(
              emailAndPassword: true, // enabled by default
              anonymous: true,
            ),
            child: MaterialApp(
              title: 'Material App',
              themeMode: ThemeMode.light,
              darkTheme: ThemeData.dark(),
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.white,
                  textTheme: ButtonTextTheme.primary,
                  height: 40,
                ),
              ),
              home: OnBoardingPage(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
