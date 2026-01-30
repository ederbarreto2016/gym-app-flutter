import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/core/local_storage_provider.dart';

import '../../../app/gym_providers.dart';
import '../domain/gym.dart';

class SelectGymPage extends ConsumerWidget {
  const SelectGymPage({super.key, required this.gyms});
  final List<Gym> gyms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar academia')),
      body: ListView.separated(
        itemCount: gyms.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final gym = gyms[index];
          return ListTile(
            title: Text(gym.name),
            subtitle: Text('id: ${gym.id}'),
            onTap: () async {
              ref.read(activeGymIdProvider.notifier).state = gym.id;
              await ref.read(localStorageProvider).setActiveGymId(gym.id);
            },
          );
        },
      ),
    );
  }
}
