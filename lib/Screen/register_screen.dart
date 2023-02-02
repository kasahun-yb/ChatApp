import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../database_Auth/authentication.dart';
import 'login_Screen.dart';
import 'verfication_screen.dart';

class register_screen extends StatefulWidget {
  const register_screen({super.key});

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  CollectionReference _cloudFirstore =
      FirebaseFirestore.instance.collection("user");

  @override
  Widget build(
    BuildContext context,
  ) {
    var file;
    bool picture = false;
    String? profile_picture;
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 30,
          foregroundColor: Color.fromARGB(255, 57, 167, 125),
          elevation: 0,
          backgroundColor: Color.fromARGB(0, 255, 255, 255)),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Create Account",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Create a new account",
                style: TextStyle(
                    color: Color.fromARGB(135, 114, 118, 121),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 5,
              ),
              InputField(false, context, Icons.person, _username, "Name"),
              SizedBox(
                height: 15,
              ),
              InputField(false, context, Icons.email, _email, "Email"),
              SizedBox(
                height: 15,
              ),
              InputField(false, context, Icons.phone_android, _phone, "Phone"),
              SizedBox(
                height: 15,
              ),
              InputField(true, context, Icons.lock, _password, "Password"),
              SizedBox(
                height: 15,
              ),
              InputField(true, context, Icons.lock, _confirmpassword,
                  "Confirm Password"),
              SizedBox(
                height: 10,
              ),
              regsterButton(context, () async {
                if (_username.text.isNotEmpty &&
                    _password.text == _confirmpassword.text &&
                    _email.text.isNotEmpty &&
                    _password.text.isNotEmpty &&
                    _phone.text.isNotEmpty) {
                  await emailAuth.sendOtp(
                    recipientMail: _email.text,
                  );

                  // insert profile picture

                  authentication auth = new authentication();
                  auth.createAccount(
                    _email.text,
                    _password.text,
                    _username.text,
                    _phone.text,
                    context,
                  );
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Verfication_screen();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "password does not match OR of Fill all Filed")));
                }
              }),
              SizedBox(
                height: 40,
              ),
              loginText(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding loginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have a account?",
            style: TextStyle(fontSize: 15),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login_Screen();
              }));
            },
            child: Text(
              "login",
              style: TextStyle(
                  color: Color.fromARGB(255, 57, 167, 125), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector regsterButton(
      BuildContext context, GestureTapCallback _function) {
    return GestureDetector(
      onTap: _function,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.81,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 167, 125),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          "Register",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }

  Container InputField(
    bool _obsecurity,
    BuildContext context,
    IconData icon,
    TextEditingController text,
    String hint,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.81,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Color.fromARGB(206, 228, 228, 228),
              offset: Offset(2, 3),
              blurRadius: 4)
        ]),
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          children: [
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 50,
              height: 59,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Center(
                  child: Icon(icon,
                      size: 35, color: Color.fromARGB(255, 57, 167, 125))),
            ),
            Expanded(
              child: TextField(
                obscureText: _obsecurity,
                controller: text,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )
          ],
        ));
  }
}
