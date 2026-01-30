import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/core/local_storage_provider.dart';

import 'gym_providers.dart';
import '../features/gym/presentation/create_gym_page.dart';
import '../features/gym/presentation/select_gym_page.dart';

class GymGate extends ConsumerWidget {
  const GymGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedGymAsync = ref.watch(savedActiveGymIdProvider);
    final activeGymId = ref.watch(activeGymIdProvider);

    return savedGymAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Erro: $e'))),
      data: (savedGymId) {
        if (activeGymId == null && savedGymId != null) {
          Future.microtask(() {
            ref.read(activeGymIdProvider.notifier).state = savedGymId;
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentGymId = ref.watch(activeGymIdProvider);
        if (currentGymId != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Academia ativa')),
            body: Center(child: Text('gymId: $currentGymId')),
          );
        }

        final gymsAsync = ref.watch(myOwnedGymsProvider);

        return gymsAsync.when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, _) => Scaffold(body: Center(child: Text('Erro: $e'))),
          data: (gyms) {
            if (gyms.isEmpty) return const CreateGymPage();
            return SelectGymPage(gyms: gyms);
          },
        );
      },
    );
  }
}
