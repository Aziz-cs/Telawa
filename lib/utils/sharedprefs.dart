import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

// SharedPreferences Keys
  static const String keyLastPage = "lastPage";

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  int get lastPage => _sharedPrefs!.getInt(keyLastPage) ?? 1;

  set lastPage(int value) {
    _sharedPrefs!.setInt(keyLastPage, value);
  }

  static void clearData() {
    _sharedPrefs!.clear();
  }
}

final sharedPrefs = SharedPrefs();
