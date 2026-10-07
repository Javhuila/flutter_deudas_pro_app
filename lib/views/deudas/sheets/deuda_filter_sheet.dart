import 'package:flutter/material.dart';

import '../../../core/enums/estado_deuda.dart';
import '../../../services/deuda/deuda_filter.dart';

class DeudaFilterSheet extends StatefulWidget {
  const DeudaFilterSheet({super.key, required this.filter});

  final DeudaFilter filter;

  @override
  State<DeudaFilterSheet> createState() => _DeudaFilterSheetState();

  static Future<DeudaFilter?> mostrar(
    BuildContext context, {
    DeudaFilter filter = const DeudaFilter(),
  }) {
    return showModalBottomSheet<DeudaFilter>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return DeudaFilterSheet(filter: filter);
      },
    );
  }
}

class _DeudaFilterSheetState extends State<DeudaFilterSheet> {
  late DeudaFilter _filter;
  late final TextEditingController _numeroDeudaController;

  @override
  void initState() {
    super.initState();

    _filter = widget.filter;
    _numeroDeudaController = TextEditingController(text: _filter.numeroDeuda);
  }

  @override
  void dispose() {
    _numeroDeudaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Filtros',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (_filter.tieneFiltros)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filter = _filter.clear();
                          _numeroDeudaController.clear();
                        });
                      },
                      child: const Text('Restablecer'),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Número de deuda',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _numeroDeudaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número de deuda',
                  hintText: 'Ej. 000045',
                  prefixIcon: Icon(Icons.tag),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _filter = _filter.copyWith(
                      numeroDeuda: value.trim(),
                      clearNumeroDeuda: value.trim().isEmpty,
                    );
                  });
                },
              ),

              const SizedBox(height: 24),

              Text(
                'Estado',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<EstadoDeuda>(
                initialValue: _filter.estado,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Estado de la deuda',
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Todos')),
                  DropdownMenuItem(
                    value: EstadoDeuda.pendiente,
                    child: Text('Pendientes'),
                  ),
                  DropdownMenuItem(
                    value: EstadoDeuda.pagada,
                    child: Text('Pagadas'),
                  ),
                  DropdownMenuItem(
                    value: EstadoDeuda.vencida,
                    child: Text('Vencidas'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _filter = _filter.copyWith(
                      estado: value,
                      clearEstado: value == null,
                    );
                  });
                },
              ),

              const SizedBox(height: 20),

              SwitchListTile(
                value: _filter.archivada == true,
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.archive_outlined),
                title: const Text('Incluir deudas archivadas'),
                subtitle: const Text(
                  'Mostrar también las deudas que han sido archivadas.',
                ),
                onChanged: (value) {
                  setState(() {
                    _filter = _filter.copyWith(
                      archivada: value,
                      clearArchivada: !value,
                    );
                  });
                },
              ),

              const SizedBox(height: 20),

              Text(
                'Ordenar por fecha de préstamo',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<bool>(
                initialValue: _filter.ascendente,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Orden',
                  prefixIcon: Icon(Icons.sort),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('Préstamos más recientes'),
                  ),
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('Préstamos más antiguos'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _filter = _filter.copyWith(ascendente: value);
                  });
                },
              ),

              const SizedBox(height: 28),

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
