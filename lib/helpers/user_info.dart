import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN = "token"; // Konstanta untuk kunci token
const String EMAIL = "email"; // Konstanta untuk kunci email pengguna
const String USERNAME = "username"; // Konstanta untuk kunci username pengguna

class UserInfo {
  // Menyimpan token ke shared preferences
  Future<void> setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(TOKEN, value);
  }

  // Menyimpan username ke shared preferences
  Future<void> setUsername(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(USERNAME, value);
  }

  // Mengambil username dari shared preferences
  Future<String?> getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USERNAME);
  }

  // Mengambil token dari shared preferences
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(TOKEN);
  }

  // Menyimpan email pengguna ke shared preferences
  Future<void> setEmail(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(EMAIL, value);
  }

  // Mengambil email pengguna dari shared preferences
  Future<String?> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(EMAIL);
  }

  // Menghapus semua data dari shared preferences (logout)
  Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
