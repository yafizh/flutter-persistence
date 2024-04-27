import 'package:shared_preferences/shared_preferences.dart';

class PersistenceSharedPreferences {

  void saveData(int counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
  }

  Future<int> readData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('counter') ?? 0;
  }

  void removeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('counter');
  }
}
