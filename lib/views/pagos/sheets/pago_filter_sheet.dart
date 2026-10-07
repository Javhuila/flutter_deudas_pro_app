import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/enums/metodo_pago.dart';
import '../../../core/enums/pago_orden.dart';
import '../../../services/pago/pago_filter.dart';

class PagoFilterSheet extends StatefulWidget {
  const PagoFilterSheet({super.key, required this.filter});

  final PagoFilter filter;

  @override
  State<PagoFilterSheet> createState() => _PagoFilterSheetState();

  static Future<PagoFilter?> mostrar(
    BuildContext context, {
    PagoFilter filter = const PagoFilter(),
  }) {
    return showModalBottomSheet<PagoFilter>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return PagoFilterSheet(filter: filter);
      },
    );
  }
}

class _PagoFilterSheetState extends State<PagoFilterSheet> {
  late PagoFilter _filter;
  late final TextEditingController _numeroBusquedaController;

  bool _buscarPorDeuda = false;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
    _buscarPorDeuda =
        _filter.numeroDeuda?.trim().isNotEmpty == true &&
        _filter.numeroPago?.trim().isEmpty != false;

    _numeroBusquedaController = TextEditingController(
      text: _buscarPorDeuda ? _filter.numeroDeuda : _filter.numeroPago,
    );
  }

  @override
  void dispose() {
    _numeroBusquedaController.dispose();
    super.dispose();
  }

  void _cambiarTipoBusqueda() {
    setState(() {
      _buscarPorDeuda = !_buscarPorDeuda;

      _numeroBusquedaController.clear();

      if (_buscarPorDeuda) {
        _filter = _filter.copyWith(
          clearNumeroPago: true,
          clearNumeroDeuda: true,
        );
      } else {
        _filter = _filter.copyWith(
          clearNumeroPago: true,
          clearNumeroDeuda: true,
        );
      }
    });
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
                          _filter = _filter.limpiar();
                          _numeroBusquedaController.clear();
                          _buscarPorDeuda = false;
                        });
                      },
                      child: const Text('Restablecer'),
                    ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _buscarPorDeuda
                          ? 'Número de la deuda'
                          : 'Número del pago',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _cambiarTipoBusqueda,
                    tooltip: _buscarPorDeuda
                        ? 'Buscar por número de pago'
                        : 'Buscar por número de deuda',
                    icon: const Icon(Icons.swap_horiz),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _numeroBusquedaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _buscarPorDeuda
                      ? 'Número de la deuda'
                      : 'Número del pago',
                  hintText: _buscarPorDeuda ? 'Ej. 000184' : 'Ej. 000026',
                  prefixIcon: const Icon(Icons.tag),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final texto = value.trim();

                  setState(() {
                    if (_buscarPorDeuda) {
                      _filter = _filter.copyWith(
                        numeroDeuda: texto,
                        clearNumeroDeuda: texto.isEmpty,
                        clearNumeroPago: true,
                      );
                    } else {
                      _filter = _filter.copyWith(
                        numeroPago: texto,
                        clearNumeroPago: texto.isEmpty,
                        clearNumeroDeuda: true,
                      );
                    }
                  });
                },
              ),

              const SizedBox(height: 24),
              Text(
                'Método de pago',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<MetodoPago>(
                initialValue: _filter.metodoPago,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Método de pago',
                  prefixIcon: Icon(Icons.payments_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Todos')),
                  DropdownMenuItem(
                    value: MetodoPago.efectivo,
                    child: Text('Efectivo'),
                  ),
                  DropdownMenuItem(
                    value: MetodoPago.transferencia,
                    child: Text('Transferencia'),
                  ),
                  DropdownMenuItem(
                    value: MetodoPago.nequi,
                    child: Text('Nequi'),
                  ),
                  DropdownMenuItem(value: MetodoPago.otro, child: Text('Otro')),
                ],
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      _filter = _filter.copyWith(clearMetodoPago: true);
                    } else {
                      _filter = _filter.copyWith(metodoPago: value);
                    }
                  });
                },
              ),

              const SizedBox(height: 20),

              Text(
                'Fecha del pago',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _seleccionarFecha(esDesde: true),
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        _filter.desde == null
                            ? 'Desde'
                            : AppConstants.formatearFecha(_filter.desde!),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _seleccionarFecha(esDesde: false),
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        _filter.hasta == null
                            ? 'Hasta'
                            : AppConstants.formatearFecha(_filter.hasta!),
                      ),
                    ),
                  ),
                ],
              ),

              if (_filter.tieneFiltroFecha) ...[
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _filter = _filter.copyWith(
                          clearDesde: true,
                          clearHasta: true,
                        );
                      });
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpiar fechas'),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              SwitchListTile(
                value: _filter.eliminado == true,
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.delete_outline),
                title: const Text('Incluir pagos eliminados'),
                subtitle: const Text(
                  'Mostrar también los pagos que fueron eliminados.',
                ),
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _filter = _filter.copyWith(eliminado: true);
                    } else {
                      _filter = _filter.copyWith(clearEliminado: true);
                    }
                  });
                },
              ),

              const SizedBox(height: 20),

              Text(
                'Ordenar por',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<PagoOrden>(
                initialValue: _filter.orden,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Orden',
                  prefixIcon: Icon(Icons.sort),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: PagoOrden.fechaDesc,
                    child: Text('Más recientes primero'),
                  ),
                  DropdownMenuItem(
                    value: PagoOrden.fechaAsc,
                    child: Text('Más antiguos primero'),
                  ),
                  DropdownMenuItem(
                    value: PagoOrden.valorDesc,
                    child: Text('Mayor valor primero'),
                  ),
                  DropdownMenuItem(
                    value: PagoOrden.valorAsc,
                    child: Text('Menor valor primero'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _filter = _filter.copyWith(orden: value);
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

  Future<void> _seleccionarFecha({required bool esDesde}) async {
    final fechaInicial = esDesde ? _filter.desde : _filter.hasta;

    final fecha = await showDatePicker(
      context: context,
      initialDate: fechaInicial ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (fecha == null || !mounted) {
      return;
    }

    setState(() {
      if (esDesde) {
        _filter = _filter.copyWith(desde: fecha);
      } else {
        _filter = _filter.copyWith(
          hasta: DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59, 999),
        );
      }
    });
  }
}
