import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/gym/data/gym_repository.dart';
import '../features/gym/domain/gym.dart';

final gymRepositoryProvider = Provider<GymRepository>((ref) {
  return GymRepository();
});

final myOwnedGymsProvider = StreamProvider<List<Gym>>((ref) {
  final repo = ref.watch(gymRepositoryProvider);
  return repo.watchMyOwnedGyms();
});

final activeGymIdProvider = StateProvider<String?>((ref) => null);
