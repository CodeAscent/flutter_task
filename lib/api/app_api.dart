import 'dart:convert';

import 'package:flutter_task/features/home/home_screen.dart';
import 'package:flutter_task/features/shared_pref/token.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppApi {
  String base_url = "https://reqres.in/api/";

  login({required String email, required String password}) async {
    Uri url = Uri.parse(base_url + "login");
    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        SharedPrefToken().saveToken(data["token"]);
        Get.to(() => HomeScreen());
      } else {
        return Get.snackbar("Message", data.toString());
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    }
  }
}
