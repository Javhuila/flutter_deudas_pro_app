import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/views/pagos/pago_page.dart';

import '../views/clientes/clientes_page.dart';
import '../views/configuracion/configuracion_page.dart';
import '../views/dashboard/dashboard_page.dart';
import '../views/deudas/deudas_page.dart';
import '../views/respaldos/respaldos_page.dart';
import 'navigation_layaout.dart';

class IniLayaout extends StatefulWidget {
  const IniLayaout({super.key});

  @override
  State<IniLayaout> createState() => _IniLayaoutState();
}

class _IniLayaoutState extends State<IniLayaout> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      DashboardPage(
        onNuevoCliente: () => _changePage(1),
        onNuevaDeuda: () => _changePage(2),
        onRegistrarPago: () => _changePage(3),
        onCrearRespaldo: _abrirRespaldo,
      ),

      const ClientesPage(),
      const DeudasPage(),
      const PagoPage(),
      const ConfiguracionPage(),
    ];
  }

  void _changePage(int index) {
    if (_currentIndex == index) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  void _abrirRespaldo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RespaldoPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: _changePage,

        destinations: NavigationLayaout.items
            .map(
              (item) => NavigationDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
