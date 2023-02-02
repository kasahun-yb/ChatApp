import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database/Screen/login_Screen.dart';
import 'package:database/assets/my_flutter_app_icons.dart';
import 'package:database/database_Auth/authentication.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'chat_screen.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({super.key});

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> with WidgetsBindingObserver {
  CollectionReference _user_check_online =
      FirebaseFirestore.instance.collection("user");
  FirebaseAuth _auth_check_online = FirebaseAuth.instance;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _user_check_online
          .doc(_auth_check_online.currentUser!.uid)
          .update({"status": "online"});
    } else {
      await _user_check_online
          .doc(_auth_check_online.currentUser!.uid)
          .update({"status": "offline"});
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    File? file;

    CollectionReference _user = FirebaseFirestore.instance.collection("user");
    FirebaseAuth _auth = FirebaseAuth.instance;

    final item = [
      Icon(
        Icons.sms,
        color: Color.fromARGB(255, 245, 245, 245),
        size: 30,
      ),
      Icon(
        Icons.call,
        color: Color.fromARGB(255, 245, 245, 245),
        size: 30,
      ),
      Icon(
        Icons.assignment_ind,
        color: Color.fromARGB(255, 245, 245, 245),
        size: 30,
      ),
      Container(
        margin: EdgeInsets.only(
          left: 2,
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              child: Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 244, 245, 245),
                size: 30,
              ),
            ),
            Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      )
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color.fromARGB(248, 255, 255, 255),
        color: Color.fromARGB(255, 3, 4, 14),
        items: item,
        animationCurve: Curves.easeInOut,
      ),
      backgroundColor: Color.fromARGB(255, 58, 139, 108),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Sunscript",
          style: TextStyle(fontSize: 19),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: InkWell(
              onTap: (() {}),
              radius: 30,
              child: Icon(
                Icons.search,
                size: 31,
              ),
            ),
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 23),
          padding: EdgeInsets.only(top: 1),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 249, 250),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: _user.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                      children: documents.map((e) {
                    return Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return chat_Screen(
                                  ppUrl: "${e['pP']}",
                                  name: "${e['name']}",
                                  lastresent: "${e['status']}",
                                  reciverId: "${e['uId']}",
                                );
                              }));
                            },
                            leading: CircleAvatar(
                                radius: 27,
                                backgroundImage: NetworkImage("${e['pP']}")),
                            title: Text(
                              "${e['name']}",
                              style: TextStyle(
                                  color: Color.fromARGB(220, 104, 105, 105),
                                  fontSize: 21),
                            ),
                            subtitle: Text(
                              "${e['email']}",
                              style: TextStyle(
                                  color: Color.fromARGB(174, 0, 0, 0),
                                  fontSize: 13),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 69),
                          height: 0.2,
                          width: double.infinity,
                          color: Color.fromARGB(47, 20, 30, 39),
                        )
                      ],
                    );
                  }).toList());
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(245, 26, 23, 31),
          child: Column(children: [
            pprow(),
            listDrower_menu(Colors.blue, "New Group", Icons.group, () {}),
            listDrower_menu(
                Colors.orange, "New Channal", MyFlutterApp.megaphone, () {}),
            listDrower_menu(Color.fromARGB(255, 224, 75, 56), "Contacts",
                Icons.person, () {}),
            listDrower_menu(
                Color.fromARGB(255, 6, 189, 82), "Calls", Icons.phone, () {}),
            listDrower_menu(
                Colors.blue, "Saved Message", Icons.bookmark, () {}),
            listDrower_menu(Color.fromARGB(255, 188, 69, 218), "Settings",
                Icons.settings, () {}),
            listDrower_menu(
                Color.fromARGB(255, 218, 104, 69), "Logout", Icons.close, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Login_Screen();
              }));
              authentication().signOut();
            }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 58, 139, 108),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  ListTile listDrower_menu(
      Color color, String title, IconData icon, GestureTapCallback _function) {
    return ListTile(
      mouseCursor: SystemMouseCursors.click,
      hoverColor: Colors.amber,
      onTap: _function,
      // enabled: true,
      leading: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        width: 30,
        height: 30,
        child: Center(
            child: Icon(
          icon,
          color: Color.fromARGB(255, 255, 250, 250),
        )),
      ),
      title: Text(
        title,
        style:
            TextStyle(color: Color.fromARGB(255, 214, 206, 206), fontSize: 19),
      ),
    );
  }

  Container pprow() {
    return Container(
      height: 250,
      color: Color.fromARGB(206, 47, 55, 74),
      padding: EdgeInsets.only(top: 10, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: 20, left: 12, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: 45, backgroundImage: NetworkImage("hh")),
                      Positioned(
                          top: 65,
                          left: 63,
                          child: InkWell(
                            onTap: () async {
                              CollectionReference _user =
                                  FirebaseFirestore.instance.collection("user");
                              var _auth =
                                  FirebaseAuth.instance.currentUser!.uid;

                              // TODO: implement initState
                              var userprofile = _user.doc("$_auth").get();

                              try {
                                var _result =
                                    await FilePicker.platform.pickFiles();
                                String filepath =
                                    "${_result!.files.single.path}";
                                var file = File(filepath);
                                if (file != null) {
                                  String _uuid = Uuid().v1();
                                  Reference _firbaseatorage = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child("$_uuid.jpg");
                                  var uploadtask =
                                      await _firbaseatorage.putFile(file);
                                  setState(() async {
                                    String profile_picture =
                                        await uploadtask.ref.getDownloadURL();
                                    var _auth = await FirebaseAuth
                                        .instance.currentUser!.uid;
                                    var _user = await FirebaseFirestore.instance
                                        .collection("user");
                                    var Addusers = await _user
                                        .doc(_auth)
                                        .update({"pP": profile_picture});

                                    print(profile_picture);
                                  });
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Color.fromARGB(255, 43, 114, 96),
                              size: 27,
                            ),
                          ))
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.lightbulb,
                      color: Colors.yellow,
                      size: 27,
                    ),
                  )
                ],
              )),
          Text(
            "Kasahun Y",
            style: TextStyle(
                fontSize: 17, color: Color.fromARGB(207, 221, 213, 213)),
          ),
          Text(
            "email@gmail.com",
            style: TextStyle(
                color: Color.fromARGB(255, 228, 223, 223), fontSize: 15),
          ),
          Container(
            padding: EdgeInsets.only(top: 56, left: 15, right: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Accounts",
                    style: TextStyle(
                        color: Color.fromARGB(255, 190, 186, 186),
                        fontSize: 23),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 31,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
