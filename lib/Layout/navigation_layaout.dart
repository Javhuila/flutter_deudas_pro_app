import 'package:flutter/material.dart';

class NavigationLayaoutItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationLayaoutItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class NavigationLayaout {
  static const items = <NavigationLayaoutItem>[
    NavigationLayaoutItem(
      label: 'Inicio',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavigationLayaoutItem(
      label: 'Clientes',
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
    ),
    NavigationLayaoutItem(
      label: 'Deudas',
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet,
    ),
    NavigationLayaoutItem(
      label: 'Pagos',
      icon: Icons.monetization_on_outlined,
      selectedIcon: Icons.monetization_on,
    ),
    NavigationLayaoutItem(
      label: 'Ajustes',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];
}
