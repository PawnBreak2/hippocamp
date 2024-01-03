import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hippocapp/constants/storage_keys.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> write(StorageKeys key, String value) async {
    await storage.write(key: describeEnum(key), value: value);
  }

  static Future<String?> read(StorageKeys key) async {
    return await storage.read(key: describeEnum(key));
  }

  static Future<void> delete(StorageKeys key) async {
    await storage.delete(key: describeEnum(key));
  }

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
