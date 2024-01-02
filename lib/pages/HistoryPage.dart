import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_mobileapps/components/BarNavigation.dart';
import 'package:rent_mobileapps/components/Layout.dart';
import 'package:rent_mobileapps/sevices/TransactionServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var transaction = <dynamic>[];

  getTransaction() async {
    await TransactionServices().getTransaction();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    transaction = jsonDecode(prefs.getString('transaction')!) as List<dynamic>;

    setState(() {});
  }

  @override
  void initState() {
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.73;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Text(
          "History Payment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Layout(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: transaction.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(35, 124, 124, 124)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: transaction[index]['user']['profile'] !=
                                        null
                                    ? Image.network(
                                        transaction[index]['user']['profile'],
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction[index]['user']['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        transaction[index]['date'],
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: transaction[index]['status'] ==
                                                'pending'
                                            ? Color.fromARGB(255, 70, 71, 74)
                                            : transaction[index]['status'] ==
                                                    'approved'
                                                ? Color.fromARGB(
                                                    255, 16, 157, 73)
                                                : transaction[index]
                                                            ['status'] ==
                                                        'unapproved'
                                                    ? const Color.fromARGB(
                                                        255, 255, 68, 68)
                                                    : transaction[index]
                                                                ['status'] ==
                                                            'finish'
                                                        ? Colors.blueAccent
                                                        : Colors.deepPurple),
                                    child: Text(
                                      transaction[index]['status'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Rp. ${transaction[index]['harga']}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Container(
                                  width: c_width,
                                  child: Text(transaction[index]['nama'])),
                              SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                visible:
                                    transaction[index]['status'] == 'finish',
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/createreview', arguments: {
                                      'id': transaction[index]['id_studio'],
                                      'idTransaksi': transaction[index]['id']
                                    });
                                  },
                                  child: Container(
                                    // width: double.maxFinite,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.deepPurple),
                                    child: Text(
                                      "Give a feedback",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }))
        ],
      )),
      bottomNavigationBar: BarNavigation(
        index: 1,
      ),
    );
  }
}
