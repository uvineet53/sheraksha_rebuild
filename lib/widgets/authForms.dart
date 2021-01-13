import 'package:flutter/material.dart';
import 'package:women_safety/services/authentication_service.dart';
import 'package:women_safety/widgets/authButtons.dart';
import 'package:women_safety/widgets/customFormField.dart';

Form signUpForm(
    confirmPassValidator,
    _formkey,
    emailController,
    confirmPasswordController,
    passwordController,
    emailValidator,
    passwordValidator) {
  return Form(
    key: _formkey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    ),
  );
}

Form signInForm(
  _formkey,
  emailController,
  passwordController,
  emailValidator,
  passwordValidator,
) {
  return Form(
    key: _formkey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customFormField(
          hint: "Email (you@example.com)",
          controller: emailController,
          validator: emailValidator,
        ),
        SizedBox(
          height: 10,
        ),
        customFormField(
            isPassword: true,
            hint: "Password (Min. 6 characters)",
            controller: passwordController,
            validator: passwordValidator),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            if (_formkey.currentState.validate()) {
              Auth().signIn(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
          child: signButton(title: "Sign In"),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
