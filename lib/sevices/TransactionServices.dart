import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rent_mobileapps/sevices/Variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionServices {
  final dio = Dio();
  final url = Variables().url;

  getTransaction() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      final id = jsonDecode(prefs.getString('user')!)['id'];

      var response = await dio.get("$url/transaksi?id-user=$id",
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

  finishTransaction(String idTransaksi) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var response = await dio.post("$url/transaksi/$idTransaksi",
          data: {
            'status': 'finished',
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
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
