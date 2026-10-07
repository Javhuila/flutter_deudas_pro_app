import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deudas_pro_app/Layout/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Layout/app_initializer.dart';
import 'core/database/database_service.dart';
import 'services/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.instance.initialize();
  await NotificationService.instance.initialize();
  await initializeDateFormatting('es');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(child: AppInitializer(child: const HomePage())));
}

class NotificationTestPage extends StatefulWidget {
  const NotificationTestPage({super.key});

  @override
  State<NotificationTestPage> createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends State<NotificationTestPage> {
  String _estado = 'Listo para probar';

  Future<void> _programarNotificacion() async {
    setState(() {
      _estado = 'Programando notificación...';
    });
    try {
      await NotificationService.instance.scheduleTestNotification();
      if (!mounted) return;
      setState(() {
        _estado = 'Notificación programada. Debe aparecer en 30 segundos.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _estado = 'ERROR: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Prueba de notificaciones')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_active_outlined, size: 64),
                const SizedBox(height: 24),
                Text(_estado, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _programarNotificacion,
                  child: const Text('Programar prueba'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
