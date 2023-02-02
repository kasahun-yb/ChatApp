import 'package:database/Screen/home_Screen.dart';
import 'package:database/Screen/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class authentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  CollectionReference _cloudFirstore =
      FirebaseFirestore.instance.collection("user");

  authentication();
  createAccount(
    String email,
    String password,
    String name,
    String phone,
    BuildContext context,
  ) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        value.user?.sendEmailVerification();

        var Addusers =
            await _cloudFirstore.doc(_firebaseAuth.currentUser!.uid).set({
          "name": name,
          "email": email,
          "phone": phone,
          "pP": "",
          "uId": value.user!.uid,
          "status": ""
        });
        signwithEmail(context, email, password);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signwithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return home_Screen();
        }));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "password or email Incorrect",
        style: TextStyle(fontSize: 18),
      )));
    }
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
