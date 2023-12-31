import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_mobileapps/sevices/AuthServices.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<MaterialColor> colors = [Colors.amber, Colors.blue, Colors.grey];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white,
            child: ListView(children: [
              Container(
                margin: const EdgeInsets.only(top: 70),
                child: Column(children: [
                  Image.asset(
                    'images/logo.png',
                    width: 260,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RENT STUDIO",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor('#291F45')),
                            )),
                        const Text("Signup your account..."),
                        const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Full Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Email Address",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurple,
                              )),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: TextField(
                            obscureText: true,
                            controller: password,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                      backgroundColor: Colors.deepPurple,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  onPressed: () async {
                                    bool status = await AuthServices().register(
                                        name: name.text,
                                        email: email.text,
                                        password: password.text);

                                    if (status) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text('Success'),
                                          content: Text(
                                              'Register user successfully'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context, 'OK');
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text('Failed'),
                                          content:
                                              Text('Register user failed!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )))
                        ]),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Have an account? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: HexColor('#291F45'),
                                        fontWeight: FontWeight.bold),
                                  ))
                            ])
                      ],
                    ),
                  )
                ]),
              )
            ])));
  }
}
