import 'package:database/Screen/forgot_password.dart';
import 'package:database/Screen/home_Screen.dart';
import 'package:database/database_Auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:database/database_Auth/authentication.dart';
import 'register_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _textEditingController_email = TextEditingController();
  TextEditingController _textEditingController_pass = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 120, bottom: 50),
              child: CircleAvatar(
                  backgroundColor: Color.fromARGB(184, 236, 237, 238),
                  radius: 50,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                  )),
            ),
            Text(
              "Wellcome back",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "login to continue",
              style: TextStyle(
                  color: Color.fromARGB(135, 114, 118, 121),
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            InputField(false, context, Icons.email_rounded,
                _textEditingController_email, "Email"),
            SizedBox(
              height: 10,
            ),
            InputField(true, context, Icons.lock_rounded,
                _textEditingController_pass, "Password"),
            SizedBox(
              height: 30,
            ),
            loginButton(
              context,
            ),
            SizedBox(
              height: 20,
            ),
            forgotPassword(),
            SizedBox(
              height: 60,
            ),
            createAccountText(context)
          ],
        ),
      ),
    );
  }

  Padding createAccountText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "don`t have account?",
            style: TextStyle(fontSize: 15),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return register_screen();
              }));
            },
            child: Text(
              "create a new account",
              style: TextStyle(
                  color: Color.fromARGB(255, 57, 167, 125), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector loginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        authentication().signwithEmail(
            context,
            _textEditingController_email.text,
            _textEditingController_pass.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.81,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 167, 125),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          "login",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }

  Padding forgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 200.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return forgot_password();
          }));
        },
        child: Text(
          "Forgot Password?",
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Color.fromARGB(255, 89, 167, 137),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
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
