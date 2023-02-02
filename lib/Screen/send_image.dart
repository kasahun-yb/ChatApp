import 'package:flutter/material.dart';

class send_image extends StatefulWidget {
  const send_image({super.key});

  @override
  State<send_image> createState() => _send_imageState();
}

class _send_imageState extends State<send_image> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        child: Column(children: [Container(), Container()]),
      )),
    );
  }
}
