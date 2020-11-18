import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:women_safety/home.dart';

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
              home: SplashScreen(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: LitAuthState(
            authenticated: MyHomeScreen(),
            unauthenticated: LitAuth.custom(
              child: CustomSignInWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSignInWidget extends StatelessWidget {
  const CustomSignInWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome', style: Theme.of(context).textTheme.headline4),
        SignInForm(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailTextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordTextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  context.signInWithEmailAndPassword();
                },
                child: Text('Sign In'),
              ),
              RaisedButton(
                onPressed: () {
                  context.signInAnonymously();
                },
                child: Text('Anony Sign In'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
