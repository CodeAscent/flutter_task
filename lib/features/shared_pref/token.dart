import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefToken {
  saveToken(token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = await sharedPreferences.getString("token");
    return token;
  }

  removeToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
  }
}
