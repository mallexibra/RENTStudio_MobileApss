import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_mobileapps/pages/SignupPage.dart';
import 'package:rent_mobileapps/sevices/AuthServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String token = "";
  List<MaterialColor> colors = [Colors.amber, Colors.blue, Colors.grey];
  bool loading = false;

  TextEditingController emailValue = TextEditingController();
  TextEditingController passwordValue = TextEditingController();

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token")!;
    });
  }

  @override
  void dispose() {
    emailValue.dispose();
    passwordValue.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    getToken();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white,
            child: ListView(
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
                            TextField(
                              controller: emailValue,
                              decoration: const InputDecoration(
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
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                obscureText: true,
                                controller: passwordValue,
                                decoration: const InputDecoration(
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
                                          backgroundColor: Colors.deepPurple,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });

                                        var login = await AuthServices().login(
                                            email: emailValue.text,
                                            password: passwordValue.text);

                                        setState(() {
                                          loading = false;
                                        });

                                        if (login['status']) {
                                          emailValue.clear();
                                          passwordValue.clear();
                                          if (login['data']['role'] != "user") {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Text('Failed'),
                                                content:
                                                    Text('You are not user!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'OK'),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                            return;
                                          } else {
                                            getToken();
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Text('Success'),
                                                content:
                                                    Text('Login Successfully'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'OK'),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          print("Login Successfully");
                                          Navigator.pushNamed(context, '/');
                                        } else {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text('Failed'),
                                              content: Text('Login Failed'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                          print("Login Failed.");
                                        }
                                      },
                                      child: Text(
                                        loading ? "Loading" : "Sign in",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )))
                            ]),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: HexColor('#291F45'),
                                            fontWeight: FontWeight.bold),
                                      ))
                                ])
                          ],
                        ),
                      ),
                    ]))
              ],
            )));
  }
}
