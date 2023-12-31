import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/StudioServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late var user;
  var studio = <dynamic>[];
  late String search;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final myData = jsonDecode(prefs.getString('user')!);

    user = myData;

    setState(() {});
  }

  getStudio() async {
    await StudioServices().getStudio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final myData = jsonDecode(prefs.getString('studios')!) as List<dynamic>;

    studio = myData;

    setState(() {});
  }

  searchStudio() async {
    await StudioServices().searchStudio(search);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final myData = jsonDecode(prefs.getString('studios')!) as List<dynamic>;

    studio = myData;

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    getStudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 8, top: 8, right: 12, bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: Colors.white),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: user['profile'] == null
                                  ? Image.network(
                                      user['profile'],
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'images/user.png',
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 7),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 146, 184, 103),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.green),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Sedang Aktif",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
                searchStudio();
              },
              decoration: InputDecoration(
                  hintText: "Search studio by name",
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.deepPurple,
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2),
                      borderRadius: BorderRadius.circular(32)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2),
                      borderRadius: BorderRadius.circular(32))),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: studio.length ?? 0,
                  itemBuilder: (_, index) {
                    String name = studio[index]['nama']!;
                    String location = studio[index]['lokasi']!;
                    String deskripsi = studio[index]['deskripsi']!;
                    String image = studio[index]['thumbnail']!;
                    return Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.deepPurple),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 178,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    size: 18,
                                  ),
                                  Text(
                                    location,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text(deskripsi),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Hello");
                            },
                            child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepPurple),
                              child: Text("Lihat Detail Studio",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BarNavigation(index: 0),
    );
  }
}
