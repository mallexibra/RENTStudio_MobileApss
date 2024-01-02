import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/AuthServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var user;
  File? profileImage;
  String? profileName;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data = jsonDecode(prefs.getString('user')!) as Map<String, dynamic>;

    user = data;

    setState(() {
      name.text = data['name'];
      email.text = data['email'];
    });
  }

  @override
  void initState() {
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
          child: ListView(
        children: [
          Text(
            "Edit Profile",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          SizedBox(height: 12),
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(46)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                child: user['profile'] != null
                    ? Image.network(
                        user['profile'],
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/user.png',
                        fit: BoxFit.cover,
                      )),
          ),
          GestureDetector(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  PlatformFile file = result.files.first;
                  profileImage = File(file.path!);
                  profileName = file.name;
                }
              },
              child: Container(
                width: 128,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Change Photo",
                      style: TextStyle(fontSize: 12, color: Colors.deepPurple),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.deepPurple,
                      size: 16,
                    )
                  ],
                ),
              )),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Lengkap",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                        hintText: "Nama Lengkap",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () async {
                    bool status = await AuthServices().editProfile(
                        name: name.text,
                        email: email.text,
                        password: password.text,
                        profile: profileImage,
                        profileName: profileName);

                    if (status) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Success'),
                          content: Text('Success edit profile!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                Navigator.pushNamed(context, '/');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      print("OK!");
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red[400]),
                    child: Text(
                      "Cancel Edit Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))
            ]),
          )
        ],
      )),
    );
  }
}
