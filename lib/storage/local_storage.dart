import 'package:hippocamp/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String?> readString(StorageKeys key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key.name);
  }

  static Future<bool> writeString(StorageKeys key, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key.name, value);
  }

  static Future<bool> deleteKey(StorageKeys key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key.name);
  }

  static Future<bool> deleteAll() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    for (var i in StorageKeys.values
        .where((e) => e != StorageKeys.firstTimeAppOpened)) {
      await sharedPreferences.remove(i.name);
    }

    return true;
  }
}
