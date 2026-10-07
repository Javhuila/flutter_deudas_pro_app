import 'package:flutter/material.dart';

import '../../../services/cliente/cliente_filter.dart';

enum ClienteOrden { nombreAsc, nombreDesc, fechaRegistroAsc, fechaRegistroDesc }

class ClienteFilterSheet extends StatefulWidget {
  const ClienteFilterSheet({super.key, required this.filter});

  final ClienteFilter filter;

  @override
  State<ClienteFilterSheet> createState() => _ClienteFilterSheetState();

  static Future<ClienteFilter?> mostrar(
    BuildContext context, {
    ClienteFilter filter = const ClienteFilter(),
  }) {
    return showModalBottomSheet<ClienteFilter>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return ClienteFilterSheet(filter: filter);
      },
    );
  }
}

class _ClienteFilterSheetState extends State<ClienteFilterSheet> {
  late ClienteFilter _filter;

  @override
  void initState() {
    super.initState();

    _filter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .75,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filtros',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (_filter.tieneFiltros)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Hay filtros aplicados.',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _filter = _filter.clear();
                      });
                    },
                    child: const Text('Restablecer'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SwitchListTile(
                value: _filter.activo == true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Solo clientes activos'),
                secondary: const Icon(Icons.verified_user_outlined),
                onChanged: (value) {
                  setState(() {
                    _filter = _filter.copyWith(
                      activo: value ? true : null,
                      clearActivo: !value,
                    );
                  });
                },
              ),

              // SwitchListTile(
              //   value: _soloConDeudas,
              //   contentPadding: EdgeInsets.zero,
              //   title: const Text('Solo clientes con deudas'),
              //   secondary: const Icon(Icons.account_balance_wallet_outlined),
              //   onChanged: (value) {
              //     setState(() {
              //       _soloConDeudas = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 24),

              Text(
                'Ordenar por',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<ClienteOrden>(
                initialValue: _filter.ordenarPor,
                isExpanded: true,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(
                    value: ClienteOrden.nombreAsc,
                    child: Text('Nombre (A-Z)'),
                  ),
                  DropdownMenuItem(
                    value: ClienteOrden.nombreDesc,
                    child: Text('Nombre (Z-A)'),
                  ),
                  DropdownMenuItem(
                    value: ClienteOrden.fechaRegistroAsc,
                    child: Text('Más antiguos'),
                  ),
                  DropdownMenuItem(
                    value: ClienteOrden.fechaRegistroDesc,
                    child: Text('Más recientes'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _filter = _filter.copyWith(ordenarPor: value);
                  });
                },
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context, _filter);
                      },
                      child: const Text('Aplicar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
