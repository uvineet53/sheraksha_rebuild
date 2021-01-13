import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/services/authentication_service.dart';
import 'package:women_safety/config/validators.dart';
import 'package:women_safety/widgets/authButtons.dart';
import 'package:women_safety/widgets/background_motion_overlay.dart';
import 'package:women_safety/widgets/customFormField.dart';
import 'package:women_safety/widgets/logoBuilder.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with Validators {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var _formkey = GlobalKey<FormState>();

  CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.asset("assets/bg_video.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundMotionOverlay(_controller),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoBuilder(),
                      SizedBox(
                        height: 20,
                      ),
                      customFormField(
                          hint: "Email (you@example.com)",
                          controller: emailController,
                          validator: emailValidator),
                      SizedBox(
                        height: 10,
                      ),
                      customFormField(
                          isPassword: true,
                          hint: "Password (Min. 6 characters)",
                          controller: passwordController,
                          validator: passwordValidator),
                      SizedBox(
                        height: 10,
                      ),
                      customFormField(
                          isPassword: true,
                          hint: "Confirm Password",
                          controller: confirmPasswordController,
                          validator: confirmPassValidator),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState.validate()) {
                            Auth().signUp(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: signButton(title: "Sign Up"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      registerUnderline(true),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String confirmPassValidator(value) {
    if (value != passwordController.text) {
      return "Passwords don't match";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
