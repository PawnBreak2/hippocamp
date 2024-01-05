import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalFileStorageManager {
  // Private method to get the application documents directory
  static Future<Directory> _getAppDocDir() async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<File> saveFile(File file) async {
    final appDocDir = await _getAppDocDir();
    final filePath = '${appDocDir.path}/${file.path.split('/').last}';
    return file.copy(filePath);
  }

  static Future<List<File>> loadFiles() async {
    final appDocDir = await _getAppDocDir();
    return Directory(appDocDir.path).listSync().whereType<File>().toList();
  }

// More methods can use _getAppDocDir() as needed
}
