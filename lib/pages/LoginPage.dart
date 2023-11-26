import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<MaterialColor> colors = [Colors.amber, Colors.blue, Colors.grey];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white,
            child: PageView(
              children: [
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
                            const Text("Login with your account..."),
                            const SizedBox(height: 20),
                            const TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Email Address",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.deepPurple,
                                  )),
                            ),
                            const SizedBox(height: 15),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
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
                                          backgroundColor: HexColor("#291F45"),
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {},
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )))
                            ])
                          ],
                        ),
                      ),
                    ]))
              ],
            )));
  }
}
