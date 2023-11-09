import 'package:flutter_riverpod/flutter_riverpod.dart';

// used as a global state to show loading indicator

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
