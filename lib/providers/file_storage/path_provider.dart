import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/services/local_file_storage/local_file_storage_manager.dart';

final localFileStorageProvider = Provider((ref) => LocalFileStorageManager());
