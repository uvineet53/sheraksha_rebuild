import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:women_safety/widgets/authForms.dart';
import 'package:women_safety/config/validators.dart';
import 'package:women_safety/widgets/background_motion_overlay.dart';
import 'package:women_safety/widgets/logoBuilder.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with Validators {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var _formkey = GlobalKey<FormState>();
  bool isSignUp = false;

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
                  child: Column(
                    children: [
                      logoBuilder(),
                      SizedBox(
                        height: 20,
                      ),
                      isSignUp
                          ? signUpForm(
                              confirmPassValidator,
                              _formkey,
                              emailController,
                              confirmPasswordController,
                              passwordController,
                              emailValidator,
                              passwordValidator)
                          : signInForm(
                              _formkey,
                              emailController,
                              passwordController,
                              emailValidator,
                              passwordValidator),
                      registerUnderline(),
                    ],
                  )),
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

  Widget registerUnderline() {
    return HStack([
      !isSignUp
          ? "No Account? ".text.lg.color(Colors.grey).make()
          : "Have an Account? ".text.lg.color(Colors.grey).make(),
      GestureDetector(
        onTap: () {
          setState(() {
            isSignUp = !isSignUp;
          });
        },
        child: isSignUp
            ? "Login Here     ".text.color(Colors.grey).bold.lg.make()
            : "Register Here     ".text.color(Colors.grey).bold.lg.make(),
      )
    ]).centered();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
