import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/local_storage.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage();
});

final savedActiveGymIdProvider = FutureProvider<String?>((ref) async {
  final storage = ref.read(localStorageProvider);
  return storage.getActiveGymId();
});
