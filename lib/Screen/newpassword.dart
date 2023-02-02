import 'package:database/Screen/login_Screen.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class newpassword extends StatefulWidget {
  const newpassword({super.key});

  @override
  State<newpassword> createState() => _newpasswordState();
}

class _newpasswordState extends State<newpassword> {
  // register_screen inputPass=new register_screen();
  TextEditingController _newpassword = TextEditingController();
  TextEditingController _comPassword = TextEditingController();
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
        padding: EdgeInsets.only(top: 45),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Enter New Password",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 50,
            ),
            InputField(true, context, Icons.lock, _newpassword, "New Password"),
            SizedBox(
              height: 21,
            ),
            InputField(
                true, context, Icons.lock, _comPassword, "Comfirm Password"),
            SizedBox(
              height: 21,
            ),
            forgotButton(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login_Screen();
              }));
            })
          ],
        ),
      )),
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
          "Save Change",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
