import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety/main.dart';
import 'package:women_safety/models/user.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<KUser> get user {
    return _firebaseAuth.authStateChanges().map(
          (User firebaseUser) => (firebaseUser != null)
              ? KUser(
                  uid: firebaseUser.uid,
                  email: firebaseUser.email,
                )
              : null,
        );
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(AuthenticationWrapper());

      return "Signed In";
    } catch (e) {
      Get.snackbar("Error Signing In", e.message,
          backgroundColor: Colors.white70);
      print(e.message);
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(AuthenticationWrapper());
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .set({"email": email, "password": password});
      return "Signed Up";
    } catch (e) {
      Get.snackbar("Error Creating Account", e.message,
          backgroundColor: Colors.white70);
      print(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Get.snackbar("Error Signing Out", e.message,
          backgroundColor: Colors.white70);
      print(e.message);
    }
  }
}
