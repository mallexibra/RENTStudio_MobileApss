import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/StudioServices.dart';

class DetailStudioPage extends StatefulWidget {
  const DetailStudioPage({super.key});

  @override
  State<DetailStudioPage> createState() => _DetailStudioPageState();
}

class _DetailStudioPageState extends State<DetailStudioPage> {
  int id = 0;
  Map studio = {};
  final rupiahFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

  Future<void> getStudio() async {
    final data = await StudioServices().getDetailStudio(id: id);
    setState(() {
      studio = data;
    });
    print("ini data $studio");
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic> && arguments.containsKey('id')) {
        id = arguments['id'];
        getStudio();
      } else {
        Navigator.pushNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.73;
    if (studio['thumbnail'] == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Loading...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: Text(
              "Detail Studio",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 178,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      studio['thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      studio['nama'],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: studio['status'] == 'tersedia'
                              ? Colors.green
                              : studio['status'] == 'dipinjam'
                                  ? Colors.red
                                  : Colors.grey),
                      child: Text(
                        studio['status'].toUpperCase(),
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      size: 18,
                    ),
                    Text(
                      studio['lokasi'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Deskripsi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(studio['deskripsi']),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Jam Buka",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("${studio['jam_buka']} - ${studio['jam_tutup']}"),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Peralatan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(studio['peralatan']),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Review and Rating",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: studio['reviews'].length,
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
                                      child: studio['reviews'][index]['users']
                                                  ['profile'] !=
                                              null
                                          ? Image.network(
                                              studio['reviews'][index]['users']
                                                  ['profile'],
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
                                      studio['reviews'][index]['users']['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text("Rating: "),
                                        Icon(Icons.star_rate_rounded,
                                            color: Colors.amber, size: 18),
                                        Text(
                                            "${studio['reviews'][index]['rating']}")
                                      ],
                                    ),
                                    Container(
                                        width: c_width,
                                        child: Text(studio['reviews'][index]
                                            ['deskripsi']))
                                  ],
                                )
                              ]));
                    })
              ],
            ),
          ),
          bottomNavigationBar: Container(
              width: double.maxFinite,
              height: 65,
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      Text(
                        rupiahFormat.format(int.parse(studio['harga'])),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/booking',
                            arguments: {'id': studio['id']});
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple),
                        child: Text(
                          "Booking Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ],
              )));
    }
  }
}
