import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionServices {
  final dio = Dio();
  final url = "http://localhost:8000/api";

  getTransaction() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var response = await dio.get("$url/transaksi?id-user=1",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        final data = jsonEncode(obj['data']);
        prefs.setString('transaction', data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
