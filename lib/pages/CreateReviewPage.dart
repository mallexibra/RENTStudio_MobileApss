import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/ReviewServices.dart';
import 'package:rent_mobileapps/sevices/StudioServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({super.key});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  int id = 0;
  int idTransaksi = 0;
  Map studio = {};
  late String idUser;
  late String rate;

  TextEditingController deksripsi = TextEditingController();

  Future<void> getStudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await StudioServices().getDetailStudio(id: id);

    setState(() {
      studio = data;
      idUser = jsonDecode(prefs.getString('user')!)['id'].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic> && arguments.containsKey('id')) {
        id = arguments['id'];
        idTransaksi = arguments['idTransaksi'];
        getStudio();
      } else {
        Navigator.pushNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Give a feedback",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Layout(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Silahkan beri feedback untuk ${studio['nama']}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.maxFinite,
            child: Column(
              children: [
                const Text(
                  "Rating",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rate = "$rating";
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Deskripsi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 250,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: deksripsi,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    bool status = await ReviewServices().createReview(
                        idUser,
                        id.toString(),
                        idTransaksi.toString(),
                        rate,
                        deksripsi.text);

                    if (status) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Success'),
                          content: Text(
                              'Success give a feedback for ${studio['nama']}!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                Navigator.pushNamed(context, '/review');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Failed'),
                          content: Text('Something wrong!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: Text(
                      "Submit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
