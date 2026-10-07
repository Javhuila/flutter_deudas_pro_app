import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/deuda_provider.dart';

class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer> {
  @override
  void initState() {
    super.initState();

    Future.microtask(_sincronizar);
  }

  Future<void> _sincronizar() async {
    try {
      await ref.read(notificationSyncServiceProvider).sincronizar();
    } catch (e) {
      debugPrint('Error al sincronizar notificaciones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
