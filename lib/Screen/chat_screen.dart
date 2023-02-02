import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:database/Screen/send_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class chat_Screen extends StatefulWidget {
  String ppUrl, name, lastresent, reciverId;
  chat_Screen(
      {super.key,
      required this.ppUrl,
      required this.name,
      required this.lastresent,
      required this.reciverId});
  @override
  State<chat_Screen> createState() => _chat_ScreenState();
}

class _chat_ScreenState extends State<chat_Screen> {
  TextEditingController _message = TextEditingController();
  TextEditingController _image_message = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var _chat = FirebaseFirestore.instance
        .collection('message')
        .doc("${_auth}${widget.reciverId}")
        .collection("chatMessage")
        .orderBy("sendtime", descending: true)
        .snapshots();
    Map<String, dynamic> message;
    bool userAlignment;
    Alignment _alignment;

    CollectionReference _collection =
        FirebaseFirestore.instance.collection('message');
    String _userphoto = "${_auth}${widget.reciverId}";
    String? fileUrl;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 133, 95),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: InkWell(
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.ppUrl),
              radius: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.name),
                  Text(
                    "${['status']}",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            )
          ]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: Container(
        color: Color.fromARGB(232, 42, 42, 49),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.23,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _chat,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              data["sendby"] == _auth
                                  ? userAlignment = false
                                  : userAlignment = true;

                              return data["messageType"] == "Text"
                                  ? messageContainer(
                                      userAlignment,
                                      data["sendby"] == _auth
                                          ? _alignment = Alignment.centerLeft
                                          : Alignment.centerRight,
                                      data["message"])
                                  : Container(
                                      alignment: data['sendby'] == _auth
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.elliptical(21, 21),
                                              bottomRight: data["sendby"] ==
                                                      widget.reciverId
                                                  ? Radius.circular(0)
                                                  : Radius.circular(10),
                                              bottomLeft: data["sendby"] ==
                                                      widget.reciverId
                                                  ? Radius.circular(10)
                                                  : Radius.circular(0),
                                              topRight: Radius.circular(10)),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromARGB(
                                                    0, 255, 255, 255),
                                                Color.fromARGB(
                                                    210, 24, 104, 104),
                                              ])),
                                      margin: EdgeInsets.only(
                                          right:
                                              data["sendby"] == _auth ? 128 : 5,
                                          left:
                                              data["sendby"] == _auth ? 5 : 128,
                                          top: 6,
                                          bottom: 10),
                                      padding: EdgeInsets.only(top: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 300,
                                            child:
                                                Image.network(data["photoUrl"]),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                bottom: 10,
                                                top: 10,
                                                right: 10),
                                            child: Text(
                                              data["message"],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    // height: 54,
                    color: Color.fromARGB(255, 36, 47, 68),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconMethod(Icons.attach_file, () async {
                          print("presed");
                          try {
                            FilePickerResult? _result =
                                await FilePicker.platform.pickFiles();
                            String filepath = "${_result!.files.single.path}";
                            File file = File(filepath);
                            if (_result != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0)), //this right here
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Image.file(
                                                      fit: BoxFit.cover, file),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10),
                                                  width: double.infinity,
                                                  color: Color.fromARGB(
                                                      255, 218, 220, 224),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: Expanded(
                                                            child: TextField(
                                                          controller:
                                                              _image_message,
                                                          maxLines: 2,
                                                          minLines: 1,
                                                          expands: false,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
                                                        )),
                                                      ),
                                                      Container(
                                                        child: InkWell(
                                                            onTap: () async {
                                                              fileUrl =
                                                                  await send_image(
                                                                file,
                                                                _collection,
                                                              );
                                                            },
                                                            child: Center(
                                                              child: Icon(
                                                                  Icons.send),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } catch (e) {}
                        }),
                        InputField(false, context, _message, "Message..."),
                        IconMethod(Icons.send, () {
                          _collection
                              .doc("${_auth}${widget.reciverId}")
                              .collection("chatMessage")
                              .add({
                            "message": _message.text,
                            "sendby": _auth,
                            "photoUrl": "",
                            "sendtime": FieldValue.serverTimestamp(),
                            "messageType": "Text"
                          });
                          _collection
                              .doc("${widget.reciverId}${_auth}")
                              .collection("chatMessage")
                              .add({
                            "message": _message.text,
                            "sendby": _auth,
                            "photoUrl": "",
                            "sendtime": FieldValue.serverTimestamp(),
                            "messageType": "Text"
                          });
                          _message.clear();
                        }),
                        IconMethod(Icons.mic, () {}),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }

  Future<String> send_image(File file, CollectionReference _collection) async {
    Navigator.pop(context);
    String filename = Uuid().v1();
    Reference _firbaseatorage =
        FirebaseStorage.instance.ref().child("$filename.jpg");

    var uploadTask = await _firbaseatorage.putFile(file);
    String fileurl = await uploadTask.ref.getDownloadURL();

    _collection
        .doc("${_auth}${widget.reciverId}")
        .collection("chatMessage")
        .add({
      "message": _image_message.text,
      "sendby": _auth,
      "photoUrl": "$fileurl",
      "sendtime": FieldValue.serverTimestamp(),
      "messageType": "File"
    });
    _collection
        .doc("${widget.reciverId}${_auth}")
        .collection("chatMessage")
        .add({
      "message": _image_message.text,
      "sendby": _auth,
      "photoUrl": "$fileurl",
      "sendtime": FieldValue.serverTimestamp(),
      "messageType": "File"
    });
    _image_message.clear();
    print(fileurl);

    return fileurl;
  }

  Container IconMethod(IconData icon, GestureTapCallback _function) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
      ),
      width: 35,
      height: 54,
      color: Color.fromARGB(0, 255, 193, 7),
      child: Center(
          child: InkWell(
        child: Icon(
          icon,
          color: Colors.white,
          size: 31,
        ),
        onTap: _function,
      )),
    );
  }

  Container messageContainer(
    bool is_right,
    Alignment alignment,
    String message,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 12),
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        // margin: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(21, 21),
              bottomRight: is_right ? Radius.circular(0) : Radius.circular(10),
              bottomLeft: is_right ? Radius.circular(10) : Radius.circular(0),
              topRight: Radius.circular(10)),
          color: Color.fromARGB(211, 52, 163, 139),
        ),
        padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
        child: Text(
          message,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
        ),
      ),
    );
  }

  Container InputField(
    bool _obsecurity,
    BuildContext context,
    TextEditingController text,
    String hint,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 2,
                minLines: 1,
                expands: false,
                obscureText: _obsecurity,
                controller: text,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(197, 255, 255, 255)),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(199, 255, 255, 255)),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )
          ],
        ));
  }
}
