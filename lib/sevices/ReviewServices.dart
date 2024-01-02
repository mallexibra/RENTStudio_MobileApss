import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rent_mobileapps/sevices/Variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewServices {
  final dio = Dio();
  final url = Variables().url;

  getReviews() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final id = jsonDecode(prefs.getString('user')!)['id'];

      var response = await dio.get("$url/reviews?id-user=$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        final data = jsonEncode(obj['data']);

        prefs.setString("reviews", data);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getReviewsByStudio(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var response = await dio.get("$url/reviews?id-studio=$id",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      Map obj = response.data;

      if (obj['status']) {
        return obj['data'];
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
