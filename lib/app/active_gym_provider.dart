import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'gym_providers.dart';
import '../features/gym/domain/gym.dart';

final activeGymProvider = FutureProvider<Gym>((ref) async {
  final gymId = ref.watch(activeGymIdProvider);
  if (gymId == null) throw Exception('Nenhuma academia ativa');

  final repo = ref.read(gymRepositoryProvider);
  return repo.getGymById(gymId);
});
