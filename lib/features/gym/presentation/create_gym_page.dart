import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/core/local_storage_provider.dart';

import '../../../app/gym_providers.dart';

class CreateGymPage extends ConsumerStatefulWidget {
  const CreateGymPage({super.key});

  ConsumerState<CreateGymPage> createState() => _CreateGymPageState();
}

class _CreateGymPageState extends ConsumerState<CreateGymPage> {
  final _name = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _create() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(gymRepositoryProvider);
      final gymId = await repo.createGym(name: _name.text.trim());

      ref.read(activeGymIdProvider.notifier).state = gymId;
      await ref.read(localStorageProvider).setActiveGymId(gymId);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar academia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nome da academia'),
            ),
            const SizedBox(height: 12),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _create,
              child: Text(_loading ? 'Criando...' : 'Criar'),
            ),
          ],
        ),
      ),
    );
  }
}
