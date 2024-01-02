import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/ReviewServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  var reviews = <dynamic>[];

  getReviews() async {
    await ReviewServices().getReviews();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data = jsonDecode(prefs.getString('reviews')!) as List<dynamic>;

    reviews = data;

    setState(() {});
  }

  @override
  void initState() {
    getReviews();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Text(
          "Your Review Studio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Layout(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(66, 205, 205, 205),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:
                                    reviews[index]['users']['profile'] != null
                                        ? Image.network(
                                            reviews[index]['users']['profile'],
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
                                reviews[index]['users']['name'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text("Rating: "),
                                  Icon(Icons.star_rate_rounded,
                                      color: Colors.amber, size: 18),
                                  Text("${reviews[index]['rating']}")
                                ],
                              ),
                              Container(
                                width: c_width,
                                child: Text(reviews[index]['deskripsi']),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }))
        ],
      )),
      bottomNavigationBar: BarNavigation(
        index: 2,
      ),
    );
  }
}
