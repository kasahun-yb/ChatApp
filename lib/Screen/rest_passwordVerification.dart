import 'package:database/Screen/home_Screen.dart';
import 'package:database/Screen/newpassword.dart';
import 'package:flutter/material.dart';

import 'login_Screen.dart';

class restpassword_Verfication_screen extends StatefulWidget {
  const restpassword_Verfication_screen({super.key});

  @override
  State<restpassword_Verfication_screen> createState() =>
      _restpassword_Verfication_screenState();
}

class _restpassword_Verfication_screenState
    extends State<restpassword_Verfication_screen> {
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
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Text(
            "Enter Rest verification Code",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              verifyInput(),
              verifyInput(),
              verifyInput(),
              verifyInput(),
            ],
          ),
          SizedBox(
            height: 89,
          ),
          verificationButton(context, () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return newpassword();
            }));
          }),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              loginText(context, "Wrong phone Number/Email?", () {}),
              loginText(context, "Resend again", () {}),
            ],
          )
        ]),
      )),
    );
  }

  Padding loginText(
      BuildContext context, String title, GestureTapCallback _function) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: _function,
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 57, 167, 125), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  SizedBox verifyInput() {
    return SizedBox(
      width: 50,
      height: 45,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 22, left: 6),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Color.fromARGB(221, 218, 215, 215),
                    offset: Offset(2, 3))
              ]),
          child: TextField(
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(137, 75, 73, 73)),
              decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(137, 75, 73, 73)),
                  border: OutlineInputBorder(borderSide: BorderSide.none))),
        ),
      ),
    );
  }

  GestureDetector verificationButton(
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
          "Verify",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
