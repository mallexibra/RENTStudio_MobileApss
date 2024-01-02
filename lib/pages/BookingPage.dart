import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/sevices/StudioServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int id = 0;
  String idUser = "0";
  String harga = "0";
  late File bukti;
  late String nameBukti;
  final rupiahFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

  TextEditingController pesan = TextEditingController();
  TextEditingController price = TextEditingController();

  getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data = jsonDecode(prefs.getString('user')!) as Map<String, dynamic>;

    idUser = data['id'].toString();
    print(idUser);
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic> && arguments.containsKey('id')) {
        id = arguments['id'];
        harga = arguments['harga'];
        getIdUser();
        setState(() {});
      } else {
        Navigator.pushNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (id == 0) {
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
            "Booking Studio",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Layout(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Silahkan melakukan pembayaran pada:",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sebesar ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        rupiahFormat.format(int.parse(harga)),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                  Text(
                    "No. Rekening 1234-2364-9823-8347",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "a.n RENT Studio (Bank BRI)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pesan Pembayaran",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextField(
                      controller: pesan,
                      decoration: InputDecoration(
                          hintText: "Pesan Pembayaran",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
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
                      "Harga Studio",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextField(
                      enabled: false,
                      controller: price,
                      decoration: InputDecoration(
                          hintText: rupiahFormat.format(int.parse(harga)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2),
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
                      "Bukti Pembayaran",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;
                          bukti = File(file.path!);
                          nameBukti = file.name;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 129, 91, 194),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          "Add File",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    bool status = await StudioServices().bookingStudio(
                        idUser,
                        id.toString(),
                        pesan.text,
                        bukti,
                        nameBukti,
                        price.text);

                    if (status) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Success'),
                          content: Text('Success booking studio!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                Navigator.pushNamed(context, '/history');
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
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: Text(
                      "Kirim Bukti Pembayaran",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      );
    }
  }
}
