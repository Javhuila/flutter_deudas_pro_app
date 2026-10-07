import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/Layout/ini_layaout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/configuracion_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuracionState = ref.watch(configuracionProvider);

    final configuracion = configuracionState.configuracion;

    final themeMode = configuracion == null
        ? ThemeMode.light
        : configuracion.temaOscuro
        ? ThemeMode.dark
        : ThemeMode.light;

    final ThemeData temaClaro = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    final ThemeData temaOscuro = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es', 'CO'),
      supportedLocales: const [Locale('es', 'CO'), Locale('es')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: 'Deudas',
      theme: temaClaro,
      darkTheme: temaOscuro,
      themeMode: themeMode,
      home: const IniLayaout(),
    );
  }
}
