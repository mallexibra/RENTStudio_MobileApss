import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final dio = Dio();
  final url = "http://localhost:8000/api";

  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var response = await dio.post("$url/register",
          data: {
            "name": name,
            "email": email,
            "role": "user",
            "password": password
          },
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.data['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map> login({required String email, required String password}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await dio.post("$url/login",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: {"email": email, "password": password});

      Map obj = response.data;
      print(obj);
      if (!obj['status']) {
        return obj;
      }

      final data = jsonEncode(obj['data']);

      await prefs.setString('user', data);
      await prefs.setString('token', obj['token']);
      await prefs.setBool('isLogin', obj['status']);

      return obj;
    } catch (e) {
      print(e.toString());
      return {"message": e.toString()};
    }
  }

  Future<bool> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var response = await dio.get("$url/logout",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      if (response.data['status']) {
        await prefs.clear();
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
