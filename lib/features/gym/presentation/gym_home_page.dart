import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/active_gym_provider.dart';
import '../../../app/gym_providers.dart';
import '../../../core/local_storage_provider.dart';
import '../../../app/session_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GymHomePage extends ConsumerWidget {
  const GymHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gymAsync = ref.watch(activeGymProvider);

    return gymAsync.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Academia')),
        body: Center(child: Text('Erro: $e')),
      ),
      data: (gym) => Scaffold(
        appBar: AppBar(
          title: Text(gym.name),
          actions: [
            IconButton(
              tooltip: 'Trocar academia',
              icon: const Icon(Icons.swap_horiz),
              onPressed: () async {
                ref.read(activeGymIdProvider.notifier).state = null;
                await ref.read(localStorageProvider).clearActiveGymId();

                ref.invalidate(savedActiveGymIdProvider);

                ref.invalidate(activeGymProvider);
              },
            ),
            IconButton(
              tooltip: 'Sair',
              icon: const Icon(Icons.logout),
              onPressed: () async {
                ref.read(activeGymIdProvider.notifier).state = null;
                await ref.read(localStorageProvider).clearActiveGymId();
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Home da academia',
                style: TextStyle(fontSize: 20, fontWeight: .bold),
              ),
              const SizedBox(height: 8),
              Text('ID: ${gym.id}'),
              const SizedBox(height: 8),
              Text('Dono: ${gym.ownerUserId}'),
              const SizedBox(height: 24),

              const Text(
                'Administração',
                style: TextStyle(fontSize: 16, fontWeight: .bold),
              ),
              const SizedBox(height: 12),

              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Gerenciar membros'),
                subtitle: const Text(
                  'Adicionar professores e alunos (próximo passo)',
                ),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text('Treinos'),
                subtitle: const Text('Criar/Visualizar treinos (depois)'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
