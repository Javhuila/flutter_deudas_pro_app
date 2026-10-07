import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
// import '../../core/enums/estado_deuda.dart';
import '../../models/cliente.dart';
import '../../models/deuda.dart';
import '../../providers/cliente_provider.dart';
import '../../providers/deuda_provider.dart';
import '../widgets/resumen_item.dart';

class DeudaFormPage extends ConsumerStatefulWidget {
  const DeudaFormPage({super.key, this.deuda});

  final Deuda? deuda;

  bool get isEditing => deuda != null;

  @override
  ConsumerState<DeudaFormPage> createState() => _DeudaFormPageState();
}

class _DeudaFormPageState extends ConsumerState<DeudaFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _capitalController;
  late final TextEditingController _interesController;
  late final TextEditingController _numeroCuotasController;
  late final TextEditingController _observacionController;
  late final TextEditingController _mesesProgramadosController;
  Cliente? _clienteSeleccionado;

  DateTime _fechaPrestamo = DateTime.now();

  DateTime? _fechaVencimiento;
  bool _tieneCuotas = false;
  bool _programada = false;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();

    final deuda = widget.deuda;

    _capitalController = TextEditingController(
      text: deuda != null ? deuda.capital.toStringAsFixed(0) : '',
    );

    _interesController = TextEditingController(
      text: deuda != null ? deuda.porcentajeInteres.toStringAsFixed(2) : '',
    );
    _numeroCuotasController = TextEditingController(
      text: deuda != null && deuda.tieneCuotas
          ? deuda.numeroCuotas.toString()
          : '',
    );
    _mesesProgramadosController = TextEditingController(
      text: deuda != null && deuda.programada
          ? deuda.mesesProgramados.toString()
          : '',
    );
    _observacionController = TextEditingController(
      text: deuda?.observacion ?? '',
    );

    _fechaPrestamo = deuda?.fechaPrestamo ?? DateTime.now();

    _fechaVencimiento = deuda?.fechaVencimiento;
    _tieneCuotas = deuda?.tieneCuotas ?? false;
    _programada = deuda?.programada ?? false;
    if (deuda != null) {
      _clienteSeleccionado = deuda.cliente.value;
    }

    // Nos aseguramos de que la lista de clientes esté cargada.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final clienteState = ref.read(clienteProvider);

      if (!clienteState.loading && clienteState.clientes.isEmpty) {
        ref.read(clienteProvider.notifier).cargar();
      }

      _sincronizarClienteConProvider();
    });
  }

  @override
  void dispose() {
    _capitalController.dispose();
    _interesController.dispose();
    _mesesProgramadosController.dispose();
    _numeroCuotasController.dispose();
    _observacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.isEditing;
    final clienteState = ref.watch(clienteProvider);

    // Si el provider acaba de cargar los clientes y estamos editando,
    // sincronizamos la instancia del cliente.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _sincronizarClienteConProvider();
    });

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar deuda' : 'Nueva deuda')),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _guardando ? null : _guardar,
          icon: _guardando
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save_outlined),
          label: Text(
            _guardando
                ? 'Guardando...'
                : isEditing
                ? 'Guardar cambios'
                : 'Registrar deuda',
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              _buildClienteSection(context, clienteState),

              const SizedBox(height: 16),

              _buildPrestamoSection(context),

              const SizedBox(height: 16),

              _buildFechasSection(context),

              const SizedBox(height: 16),

              _buildObservacionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClienteSection(BuildContext context, ClienteState clienteState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            if (clienteState.loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (clienteState.error != null)
              _buildClienteError(context)
            else if (clienteState.clientes.isEmpty)
              _buildSinClientes(context)
            else
              _buildClienteAutocomplete(context, clienteState),
          ],
        ),
      ),
    );
  }

  Widget _buildClienteAutocomplete(
    BuildContext context,
    ClienteState clienteState,
  ) {
    return Autocomplete<Cliente>(
      displayStringForOption: (cliente) {
        return cliente.nombre;
      },

      initialValue: TextEditingValue(text: _clienteSeleccionado?.nombre ?? ''),

      optionsBuilder: (TextEditingValue textEditingValue) {
        final texto = textEditingValue.text.trim().toLowerCase();

        if (texto.isEmpty) {
          return clienteState.clientes;
        }

        return clienteState.clientes.where((cliente) {
          final nombre = cliente.nombre.toLowerCase();

          final telefono = (cliente.telefono ?? '').toLowerCase();

          return nombre.contains(texto) || telefono.contains(texto);
        });
      },

      onSelected: (Cliente cliente) {
        setState(() {
          _clienteSeleccionado = cliente;
        });
      },

      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: !_guardando,
              textInputAction: TextInputAction.search,

              decoration: const InputDecoration(
                labelText: 'Seleccionar cliente',
                hintText: 'Buscar por nombre o teléfono...',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),

              validator: (_) {
                if (_clienteSeleccionado == null) {
                  return 'Selecciona un cliente';
                }

                return null;
              },

              onChanged: (texto) {
                // Si el usuario modifica manualmente el texto,
                // deja de existir una selección válida.
                if (_clienteSeleccionado != null &&
                    texto != _clienteSeleccionado!.nombre) {
                  setState(() {
                    _clienteSeleccionado = null;
                  });
                }
              },

              onFieldSubmitted: (_) {
                onFieldSubmitted();
              },
            );
          },

      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<Cliente> onSelected,
            Iterable<Cliente> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cliente = options.elementAt(index);

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(AppConstants.iniciales(cliente.nombre)),
                        ),

                        title: Text(
                          cliente.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        subtitle: (cliente.telefono ?? '').isNotEmpty
                            ? Text(cliente.telefono!)
                            : null,

                        trailing: cliente.activo
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                              ),

                        onTap: () {
                          onSelected(cliente);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
    );
  }

  // ============================================================
  // SINCRONIZAR CLIENTE
  // ============================================================

  void _sincronizarClienteConProvider() {
    if (!widget.isEditing) {
      return;
    }

    final seleccionado = _clienteSeleccionado;

    if (seleccionado == null) {
      return;
    }

    final clienteState = ref.read(clienteProvider);

    if (clienteState.loading || clienteState.clientes.isEmpty) {
      return;
    }

    Cliente? clienteActual;

    for (final cliente in clienteState.clientes) {
      if (cliente.id == seleccionado.id) {
        clienteActual = cliente;
        break;
      }
    }

    if (clienteActual == null) {
      return;
    }

    if (_clienteSeleccionado!.id == clienteActual.id &&
        identical(_clienteSeleccionado, clienteActual)) {
      return;
    }

    setState(() {
      _clienteSeleccionado = clienteActual;
    });
  }

  Widget _buildClienteError(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'No se pudieron cargar los clientes.',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'Intenta nuevamente antes de registrar la deuda.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              ref.read(clienteProvider.notifier).cargar();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Recargar clientes'),
          ),
        ],
      ),
    );
  }

  Widget _buildSinClientes(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 36,
            color: theme.colorScheme.onSurfaceVariant,
          ),

          const SizedBox(height: 12),

          Text(
            'No hay clientes registrados',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Registra un cliente antes de crear una deuda.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrestamoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del préstamo',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _capitalController,
              enabled: !_guardando,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Capital prestado',
                hintText: '0',
                prefixIcon: Icon(Icons.payments_outlined),
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
              validator: _validarCapital,
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _interesController,
              enabled: !_guardando,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Porcentaje de interés',
                hintText: '0',
                prefixIcon: Icon(Icons.percent),
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
              validator: _validarInteres,
              onChanged: (_) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Deuda programada'),
              subtitle: Text(
                _programada
                    ? 'Genera interés mensualmente durante la duración establecida.'
                    : 'La deuda no tendrá una duración programada.',
              ),
              secondary: const Icon(Icons.calendar_view_month_outlined),
              value: _programada,
              onChanged: _guardando
                  ? null
                  : (value) {
                      setState(() {
                        _programada = value;

                        if (!value) {
                          _mesesProgramadosController.clear();
                        }
                      });
                    },
            ),

            if (_programada) ...[
              const SizedBox(height: 12),

              TextFormField(
                controller: _mesesProgramadosController,
                enabled: !_guardando,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Duración en meses',
                  hintText: 'Ej. 3',
                  prefixIcon: Icon(Icons.timelapse_outlined),
                  suffixText: 'meses',
                  border: OutlineInputBorder(),
                ),
                validator: _validarMesesProgramados,
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ],

            const SizedBox(height: 16),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Esta deuda tiene cuotas'),
              subtitle: Text(
                _tieneCuotas
                    ? _programada
                          ? 'Las cuotas se distribuirán sobre la obligación total.'
                          : 'El capital se dividirá en cuotas.'
                    : 'La deuda se manejará sin cuotas.',
              ),
              secondary: const Icon(Icons.calendar_view_month_outlined),
              value: _tieneCuotas,
              onChanged: _guardando
                  ? null
                  : (value) {
                      setState(() {
                        _tieneCuotas = value;

                        if (!value) {
                          _numeroCuotasController.clear();
                        }
                      });
                    },
            ),

            if (_tieneCuotas) ...[
              const SizedBox(height: 12),

              TextFormField(
                controller: _numeroCuotasController,
                enabled: !_guardando,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Número de cuotas',
                  hintText: 'Ej. 6',
                  prefixIcon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(),
                ),
                validator: _validarNumeroCuotas,
                // onChanged: (_) {
                //   setState(() {});
                // },
              ),
              const SizedBox(height: 12),

              _buildResumenCuotas(context),
            ],
            const SizedBox(height: 16),
            _buildResumenPrestamo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResumenCuotas(BuildContext context) {
    final capital =
        double.tryParse(_capitalController.text.replaceAll(',', '.')) ?? 0;
    final porcentaje =
        double.tryParse(_interesController.text.replaceAll(',', '.')) ?? 0;
    final numeroCuotas = int.tryParse(_numeroCuotasController.text.trim()) ?? 0;

    if (!_tieneCuotas || numeroCuotas <= 0) {
      return const SizedBox.shrink();
    }
    final interesMensual = capital * porcentaje / 100;

    final mesesProgramados =
        int.tryParse(_mesesProgramadosController.text.trim()) ?? 0;

    final interesTotalProgramado = _programada && mesesProgramados > 0
        ? interesMensual * mesesProgramados
        : 0;

    final obligacionTotal = _programada
        ? capital + interesTotalProgramado
        : capital;

    final valorCuota = obligacionTotal / numeroCuotas;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calculate_outlined),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  _programada
                      ? 'Distribución de la obligación'
                      : 'Distribución del capital',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ResumenItem(
            titulo: 'Capital',
            valor: AppConstants.formatearMoneda(capital),
          ),

          if (_programada) ...[
            const SizedBox(height: 8),

            ResumenItem(
              titulo: 'Interés total programado',
              valor: AppConstants.formatearMoneda(interesTotalProgramado),
            ),
            const SizedBox(height: 8),

            ResumenItem(
              titulo: 'Obligación total',
              valor: AppConstants.formatearMoneda(obligacionTotal),
            ),
          ],
          const SizedBox(height: 8),

          ResumenItem(
            titulo: 'Número de cuotas',
            valor: numeroCuotas.toString(),
          ),

          const Divider(height: 20),

          ResumenItem(
            titulo: 'Valor aproximado por cuota',
            valor: AppConstants.formatearMoneda(valorCuota),
            destacado: true,
          ),

          const SizedBox(height: 8),

          Text(
            _programada
                ? 'En una deuda programada, las cuotas cubren la obligación total, incluyendo los intereses de los períodos programados.'
                : 'El valor de las cuotas se calcula sobre el capital. El interés se administra por separado.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumenPrestamo(BuildContext context) {
    final capital =
        double.tryParse(_capitalController.text.replaceAll(',', '.')) ?? 0;

    final porcentaje =
        double.tryParse(_interesController.text.replaceAll(',', '.')) ?? 0;

    final mesesProgramados =
        int.tryParse(_mesesProgramadosController.text.trim()) ?? 0;

    final interesMensual = capital * porcentaje / 100;

    final interesTotal = _programada
        ? interesMensual * mesesProgramados
        : interesMensual;

    final total = capital + interesTotal;

    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ResumenItem(
            titulo: 'Capital',
            valor: AppConstants.formatearMoneda(capital),
          ),

          const SizedBox(height: 8),
          if (_programada) ...[
            ResumenItem(
              titulo: 'Interés mensual',
              valor: AppConstants.formatearMoneda(interesMensual),
            ),

            const SizedBox(height: 8),

            ResumenItem(
              titulo: 'Interés total',
              valor: AppConstants.formatearMoneda(interesTotal),
            ),
          ] else
            ResumenItem(
              titulo: 'Interés',
              valor: AppConstants.formatearMoneda(interesTotal),
            ),

          const Divider(height: 20),

          ResumenItem(
            titulo: 'Total',
            valor: AppConstants.formatearMoneda(total),
            destacado: true,
          ),
          if (_programada) ...[
            const SizedBox(height: 8),

            Text(
              '$mesesProgramados ${mesesProgramados == 1 ? 'mes' : 'meses'} de duración · '
              '30 días por período',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFechasSection(BuildContext context) {
    DateTime? fechaVencimientoCalculada;
    final mesesProgramados =
        int.tryParse(_mesesProgramadosController.text.trim()) ?? 0;

    if (_programada && mesesProgramados > 0) {
      fechaVencimientoCalculada = _fechaPrestamo.add(
        Duration(days: mesesProgramados * 30),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fechas',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('Fecha del préstamo'),
              subtitle: Text(AppConstants.formatearFecha(_fechaPrestamo)),
              trailing: const Icon(Icons.chevron_right),
              onTap: _guardando ? null : _seleccionarFechaPrestamo,
            ),

            const Divider(),
            if (_programada)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_available_outlined),
                title: const Text('Fecha de vencimiento'),
                subtitle: Text(
                  fechaVencimientoCalculada == null
                      ? 'Ingresa la duración en meses'
                      : AppConstants.formatearFecha(fechaVencimientoCalculada),
                ),
              )
            else
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_outlined),
                title: const Text('Fecha de vencimiento'),
                subtitle: Text(
                  _fechaVencimiento == null
                      ? 'Sin fecha de vencimiento'
                      : AppConstants.formatearFecha(_fechaVencimiento!),
                ),
                trailing: _fechaVencimiento == null
                    ? const Icon(Icons.chevron_right)
                    : IconButton(
                        onPressed: _guardando
                            ? null
                            : () {
                                setState(() {
                                  _fechaVencimiento = null;
                                });
                              },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Quitar fecha',
                      ),
                onTap: _guardando ? null : _seleccionarFechaVencimiento,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildObservacionSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: _observacionController,
          minLines: 3,
          maxLines: 6,
          enabled: !_guardando,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Observaciones',
            hintText: 'Agregar una observación...',
            prefixIcon: Icon(Icons.notes_outlined),
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarFechaPrestamo() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaPrestamo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Selecciona la fecha del préstamo',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      initialDatePickerMode: DatePickerMode.day,
    );

    if (fecha == null) {
      return;
    }

    setState(() {
      _fechaPrestamo = fecha;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
  }

  Future<void> _seleccionarFechaVencimiento() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaVencimiento ?? _fechaPrestamo,
      firstDate: _fechaPrestamo,
      lastDate: DateTime(2100),
      helpText: 'Selecciona la fecha de vencimiento',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      initialDatePickerMode: DatePickerMode.day,
    );

    if (fecha == null) {
      return;
    }

    setState(() {
      _fechaVencimiento = fecha;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
  }

  void _guardar() async {
    if (_guardando) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_clienteSeleccionado == null) {
      return;
    }

    final capital = double.tryParse(
      _capitalController.text.replaceAll(',', '.'),
    );

    if (capital == null) {
      return;
    }

    final numeroCuotas = _tieneCuotas
        ? int.tryParse(_numeroCuotasController.text.trim()) ?? 0
        : 0;
    final mesesProgramados = _programada
        ? int.tryParse(_mesesProgramadosController.text.trim()) ?? 0
        : 0;
    final porcentaje =
        double.tryParse(_interesController.text.replaceAll(',', '.')) ?? 0;

    setState(() {
      _guardando = true;
    });
    try {
      final deuda = widget.deuda ?? Deuda();

      deuda.cliente.value = _clienteSeleccionado;
      deuda.capital = capital;
      deuda.tieneCuotas = _tieneCuotas;
      deuda.numeroCuotas = numeroCuotas;
      deuda.porcentajeInteres = porcentaje;
      deuda.programada = _programada;
      deuda.mesesProgramados = mesesProgramados;
      deuda.fechaPrestamo = _fechaPrestamo;
      if (_programada) {
        deuda.fechaVencimiento = _fechaPrestamo.add(
          Duration(days: mesesProgramados * 30),
        );
      } else {
        deuda.fechaVencimiento = _fechaVencimiento;
      }
      deuda.observacion = _observacionController.text.trim();

      // La creación/actualización real se conectará
      // posteriormente con DeudaProvider/DeudaService.
      // Recalcular los valores derivados de la deuda.
      // deuda.interesCalculado = deuda.capital * (deuda.porcentajeInteres / 100);

      // deuda.total = deuda.capital + deuda.interesCalculado;

      // En una deuda nueva totalPagado inicia en 0.
      // En una deuda existente se conserva el valor
      // que ya tenía.
      // deuda.saldoPendiente = deuda.total - deuda.totalPagado;

      // if (deuda.saldoPendiente < 0) {
      // deuda.saldoPendiente = 0;
      // }

      // deuda.estado = _determinarEstado(deuda);

      if (widget.isEditing) {
        await ref.read(deudaProvider.notifier).actualizar(deuda);
      } else {
        await ref.read(deudaProvider.notifier).guardar(deuda);
      }

      if (!mounted) {
        return;
      }
      Navigator.pop(context, deuda);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo guardar la deuda: ${e.toString()}'),
          action: SnackBarAction(label: 'Cerrar', onPressed: () {}),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _guardando = false;
        });
      }
    }
  }

  // EstadoDeuda _determinarEstado(Deuda deuda) {
  //   if (deuda.saldoPendiente <= 0) {
  //     return EstadoDeuda.pagada;
  //   }

  //   if (deuda.fechaVencimiento != null &&
  //       DateTime.now().isAfter(deuda.fechaVencimiento!)) {
  //     return EstadoDeuda.vencida;
  //   }

  //   return EstadoDeuda.pendiente;
  // }

  String? _validarCapital(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa el capital prestado';
    }

    final capital = double.tryParse(value.replaceAll(',', '.'));

    if (capital == null) {
      return 'Ingresa un valor válido';
    }

    if (capital <= 0) {
      return 'El capital debe ser mayor que cero';
    }

    return null;
  }

  String? _validarInteres(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final interes = double.tryParse(value.replaceAll(',', '.'));

    if (interes == null) {
      return 'Ingresa un porcentaje válido';
    }

    if (interes < 0) {
      return 'El interés no puede ser negativo';
    }

    return null;
  }

  String? _validarNumeroCuotas(String? value) {
    if (!_tieneCuotas) {
      return null;
    }

    if (value == null || value.trim().isEmpty) {
      return 'Ingresa el número de cuotas';
    }

    final numero = int.tryParse(value.trim());

    if (numero == null) {
      return 'Ingresa un número entero válido';
    }

    if (numero <= 0) {
      return 'El número de cuotas debe ser mayor que cero';
    }

    return null;
  }

  String? _validarMesesProgramados(String? value) {
    if (!_programada) {
      return null;
    }

    if (value == null || value.trim().isEmpty) {
      return 'Ingresa la duración en meses';
    }

    final meses = int.tryParse(value.trim());

    if (meses == null) {
      return 'Ingresa un número entero válido';
    }

    if (meses <= 0) {
      return 'La duración debe ser mayor que cero';
    }

    return null;
  }
}
