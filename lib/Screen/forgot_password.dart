import 'package:database/Screen/rest_passwordVerification.dart';
import 'package:flutter/material.dart';

import 'newpassword.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({super.key});

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  TextEditingController _rest_Email_phone_ = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Rest Password",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 50,
            ),
            InputField(false, context, Icons.phone, _rest_Email_phone_,
                "Email or Phone"),
            SizedBox(
              height: 21,
            ),
            forgotButton(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return restpassword_Verfication_screen();
              }));
            })
          ],
        ),
      )),
    );
  }

///////////////////////////////
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
  ////////////////////////////

  GestureDetector forgotButton(
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
          "Rest Password",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
