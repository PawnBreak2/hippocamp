import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/helpers/db/setup/hippocamp_local_database.dart';

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  return database;
});
