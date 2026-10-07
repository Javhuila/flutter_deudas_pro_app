import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/estado_cuota.dart';
import '../../core/enums/estado_deuda.dart';
import '../../core/enums/metodo_pago.dart';
import '../../core/enums/tipo_pago.dart';
import '../../models/cuota_deuda.dart';
import '../../models/deuda.dart';
import '../../models/interes_deuda.dart';
import '../../models/pago.dart';
import '../../providers/pago_provider.dart';
import '../widgets/resumen_item.dart';

class PagoFormPage extends ConsumerStatefulWidget {
  const PagoFormPage({super.key, this.pago, required this.deudas});

  final Pago? pago;

  final List<Deuda> deudas;

  bool get isEditing => pago != null;

  @override
  ConsumerState<PagoFormPage> createState() => _PagoFormPageState();
}

class _PagoFormPageState extends ConsumerState<PagoFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _valorController;
  late final TextEditingController _referenciaController;
  late final TextEditingController _observacionController;

  Deuda? _deudaSeleccionadaActual;
  bool _cargandoDeudaInicial = false;
  bool _cargandoConceptos = false;
  TipoPago _tipoPago = TipoPago.capital;
  MetodoPago _metodoPago = MetodoPago.efectivo;
  DateTime _fechaPago = DateTime.now();
  List<CuotaDeuda> _cuotasDisponibles = [];
  final List<CuotaDeuda> _cuotasSeleccionadas = [];

  List<InteresDeuda> _interesesDisponibles = [];
  InteresDeuda? _interesSeleccionado;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();

    final pago = widget.pago;

    _valorController = TextEditingController(
      text: pago != null ? pago.valor.toStringAsFixed(0) : '',
    );

    _referenciaController = TextEditingController(text: pago?.referencia ?? '');

    _observacionController = TextEditingController(
      text: pago?.observacion ?? '',
    );

    _metodoPago = pago?.metodoPago ?? MetodoPago.efectivo;
    _fechaPago = pago?.fechaPago ?? DateTime.now();
    _tipoPago = pago?.tipoPago ?? TipoPago.capital;

    if (pago != null) {
      _cargarDeudaInicial(pago);
    }
  }

  Future<void> _cargarDeudaInicial(Pago pago) async {
    setState(() {
      _cargandoDeudaInicial = true;
      _cargandoConceptos = true;
    });

    try {
      await pago.deuda.load();

      if (!mounted) {
        return;
      }

      final deuda = pago.deuda.value;

      if (deuda == null) {
        setState(() {
          _deudaSeleccionadaActual = null;
          _cargandoDeudaInicial = false;
          _cargandoConceptos = false;
        });
        return;
      }

      Deuda? deudaActual;

      for (final deudaLista in widget.deudas) {
        if (deudaLista.id == deuda.id) {
          deudaActual = deudaLista;
          break;
        }
      }

      final deudaSeleccionada = deudaActual ?? deuda;

      setState(() {
        _deudaSeleccionadaActual = deudaSeleccionada;
        _cargandoDeudaInicial = false;
      });
      await _cargarConceptosDeuda(deudaSeleccionada, pago: pago);
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _deudaSeleccionadaActual = null;
        _cargandoDeudaInicial = false;
        _cargandoConceptos = false;
      });

      debugPrint('ERROR AL CARGAR DEUDA DEL PAGO: $e');
    }
  }

  Future<void> _cargarConceptosDeuda(Deuda deuda, {Pago? pago}) async {
    setState(() {
      _cargandoConceptos = true;
    });

    try {
      debugPrint('========== CARGANDO CONCEPTOS ==========');
      debugPrint('Deuda ID: ${deuda.id}');
      debugPrint('Deuda UUID: ${deuda.uuid}');
      debugPrint('Tiene cuotas: ${deuda.tieneCuotas}');
      debugPrint('Número cuotas: ${deuda.numeroCuotas}');
      debugPrint('Capital: ${deuda.capital}');
      debugPrint('Interés calculado: ${deuda.interesCalculado}');

      debugPrint('Antes de cuotas.load()');
      await deuda.cuotas.load();
      debugPrint('Después de cuotas.load()');
      debugPrint('Cuotas encontradas: ${deuda.cuotas.length}');

      debugPrint('Antes de intereses.load()');
      await deuda.intereses.load();
      debugPrint('Después de intereses.load()');
      debugPrint('Intereses encontrados: ${deuda.intereses.length}');

      final cuotas = deuda.cuotas.toList()
        ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      final intereses = deuda.intereses.toList()
        ..sort((a, b) => a.numeroPeriodo.compareTo(b.numeroPeriodo));
      for (final cuota in cuotas) {
        debugPrint(
          'CUOTA -> '
          'ID: ${cuota.id}, '
          'Número: ${cuota.numeroCuota}, '
          'Valor: ${cuota.valor}, '
          'Pagado: ${cuota.valorPagado}, '
          'Estado: ${cuota.estado}',
        );
      }
      for (final interes in intereses) {
        debugPrint(
          'INTERÉS -> '
          'ID: ${interes.id}, '
          'Período: ${interes.numeroPeriodo}, '
          'Valor: ${interes.valor}, '
          'Pagado: ${interes.valorPagado}, '
          'Saldo: ${interes.saldoPendiente}, '
          'Pagado: ${interes.pagado}',
        );
      }
      if (!mounted) {
        return;
      }

      // Guardamos las selecciones actuales antes de actualizar las listas.
      final interesSeleccionadoId = _interesSeleccionado?.id;
      final cuotasSeleccionadasIds = _cuotasSeleccionadas
          .map((cuota) => cuota.id)
          .toSet();

      setState(() {
        _cuotasDisponibles = cuotas;
        _interesesDisponibles = intereses;
        // Restauramos las cuotas que todavía existan.
        _cuotasSeleccionadas
          ..clear()
          ..addAll(
            cuotas.where((cuota) => cuotasSeleccionadasIds.contains(cuota.id)),
          );
        _interesSeleccionado = null;
        if (interesSeleccionadoId != null) {
          for (final interes in intereses) {
            if (interes.id == interesSeleccionadoId) {
              _interesSeleccionado = interes;
              break;
            }
          }
        }
      });

      if (pago != null) {
        await pago.cuotas.load();
        await pago.interes.load();
        debugPrint('PAGO EN EDICIÓN');
        debugPrint('Pago ID: ${pago.id}');
        debugPrint('Pago tipo: ${pago.tipoPago}');
        debugPrint('Pago valor: ${pago.valor}');
        debugPrint('Cuotas del pago: ${pago.cuotas.length}');
        debugPrint('Interés del pago: ${pago.interes.value?.id}');
        if (!mounted) {
          return;
        }
        final cuotasPago = pago.cuotas.toList();
        final interesPago = pago.interes.value;
        setState(() {
          _cuotasSeleccionadas.clear();
          for (final cuota in cuotas) {
            if (cuotasPago.any((c) => c.id == cuota.id)) {
              _cuotasSeleccionadas.add(cuota);
            }
          }

          _interesSeleccionado = null;

          if (interesPago != null) {
            for (final interes in intereses) {
              if (interes.id == interesPago.id) {
                _interesSeleccionado = interes;
                break;
              }
            }
          }
        });
      }
    } catch (e, stackTrace) {
      debugPrint('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      debugPrint('ERROR AL CARGAR CONCEPTOS');
      debugPrint('ERROR: $e');
      debugPrint('STACKTRACE:');
      debugPrintStack(stackTrace: stackTrace);
      debugPrint('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    } finally {
      if (mounted) {
        setState(() {
          _cargandoConceptos = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _valorController.dispose();
    _referenciaController.dispose();
    _observacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.isEditing;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar pago' : 'Registrar pago')),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _guardando ? null : _guardar,
          icon: _guardando
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save_outlined),
          label: Text(
            _guardando
                ? 'Guardando...'
                : isEditing
                ? 'Guardar cambios'
                : 'Registrar pago',
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deuda',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (_cargandoDeudaInicial)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        _buildDeudaAutocomplete(context),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información del pago',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      _buildTipoPagoSelector(context),

                      const SizedBox(height: 16),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _valorController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Valor del pago',
                          prefixIcon: Icon(Icons.payments_outlined),
                          prefixText: '\$ ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final texto = value?.trim() ?? '';

                          if (texto.isEmpty) {
                            return 'Ingresa el valor del pago';
                          }

                          final valor = double.tryParse(
                            texto.replaceAll(',', '.'),
                          );

                          if (valor == null) {
                            return 'Ingresa un valor válido';
                          }

                          if (valor <= 0) {
                            return 'El valor debe ser mayor que cero';
                          }

                          if (_deudaSeleccionada != null) {
                            if (_tipoPago == TipoPago.capital &&
                                _deudaSeleccionada!.tieneCuotas &&
                                _cuotasSeleccionadas.isEmpty) {
                              return 'Selecciona al menos una cuota';
                            }

                            // if (_tipoPago == TipoPago.interes &&
                            //     _interesSeleccionado == null) {
                            //   return 'Selecciona un período de interés';
                            // }

                            if (valor > _saldoDisponible) {
                              return 'El valor no puede superar el saldo disponible '
                                  '(${AppConstants.formatearMoneda(_saldoDisponible)})';
                            }
                          }

                          if (_deudaSeleccionada != null &&
                              valor > _saldoDisponible) {
                            return 'El valor no puede superar el saldo disponible '
                                '(${AppConstants.formatearMoneda(_saldoDisponible)})';
                          }

                          return null;
                        },
                      ),

                      if ((_tipoPago == TipoPago.capital ||
                              (_deudaSeleccionada?.programada == true &&
                                  _deudaSeleccionada?.tieneCuotas == true)) &&
                          _deudaSeleccionada?.tieneCuotas == true) ...[
                        const SizedBox(height: 16),
                        _buildCuotasSection(context),
                      ],

                      if (_tipoPago == TipoPago.interes &&
                          !(_deudaSeleccionada?.programada == true &&
                              _deudaSeleccionada?.tieneCuotas == true)) ...[
                        const SizedBox(height: 16),
                        _buildInteresSection(context),
                      ],

                      const SizedBox(height: 16),

                      DropdownButtonFormField<MetodoPago>(
                        initialValue: _metodoPago,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Método de pago',
                          prefixIcon: Icon(Icons.payment_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
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
                          DropdownMenuItem(
                            value: MetodoPago.otro,
                            child: Text('Otro'),
                          ),
                        ],
                        onChanged: _guardando
                            ? null
                            : (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _metodoPago = value;
                                });
                              },
                      ),

                      const SizedBox(height: 16),

                      ListTile(
                        enabled: !_guardando,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.calendar_today_outlined),
                        title: const Text('Fecha del pago'),
                        subtitle: Text(AppConstants.formatearFecha(_fechaPago)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _guardando ? null : _seleccionarFecha,
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _referenciaController,
                        enabled: !_guardando,
                        decoration: const InputDecoration(
                          labelText: 'Referencia',
                          hintText: 'Ej. número de transferencia',
                          prefixIcon: Icon(Icons.tag_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _observacionController,
                        enabled: !_guardando,
                        minLines: 3,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Observaciones',
                          prefixIcon: Icon(Icons.notes_outlined),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (_deudaSeleccionada != null)
                _ResumenDeudaCard(
                  deuda: _deudaSeleccionada!,
                  saldoDisponible: _saldoDisponible,
                  tipoPago: _tipoPago,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Deuda? get _deudaSeleccionada {
    return _deudaSeleccionadaActual;
  }

  String _nombreDeuda(Deuda deuda) {
    final cliente = deuda.cliente.value;

    return cliente?.nombre ?? 'Cliente desconocido';
  }

  double get _saldoDisponible {
    final deuda = _deudaSeleccionada;

    if (deuda == null) {
      return 0;
    }
    // DEUDA PROGRAMADA CON CUOTAS
    if (deuda.programada && deuda.tieneCuotas) {
      double saldo = deuda.saldoPendiente;

      if (widget.isEditing && widget.pago != null) {
        saldo += widget.pago!.valor;
      }

      return saldo;
    }
    // INTERÉS NORMAL
    if (_tipoPago == TipoPago.interes) {
      final interes = _interesSeleccionado;

      if (interes == null) {
        return 0;
      }

      double saldo = interes.saldoPendiente;

      if (widget.isEditing &&
          widget.pago != null &&
          widget.pago!.tipoPago == TipoPago.interes &&
          widget.pago!.interes.value?.id == interes.id) {
        saldo += widget.pago!.valor;
      }

      return saldo;
    }
    // CAPITAL NORMAL SIN CUOTAS
    if (!deuda.tieneCuotas) {
      if (!widget.isEditing || widget.pago == null) {
        return deuda.capital - _capitalPagadoDeuda(deuda);
      }

      return deuda.capital -
          _capitalPagadoDeuda(deuda, excluirPagoId: widget.pago!.id);
    }
    // CAPITAL NORMAL CON CUOTAS
    double saldo = 0;

    for (final cuota in _cuotasSeleccionadas) {
      saldo += cuota.saldoPendiente;
    }

    if (widget.isEditing &&
        widget.pago != null &&
        widget.pago!.tipoPago == TipoPago.capital) {
      saldo += widget.pago!.valor;
    }

    return saldo;
  }

  double _capitalPagadoDeuda(Deuda deuda, {int? excluirPagoId}) {
    // Esta validación visual utiliza el valor actualmente calculado
    // por la deuda. La validación definitiva permanece en PagoService.
    double pagado = deuda.capital - deuda.saldoPendiente;

    if (pagado < 0) {
      pagado = 0;
    }

    if (excluirPagoId != null && widget.pago != null) {
      pagado -= widget.pago!.valor;

      if (pagado < 0) {
        pagado = 0;
      }
    }

    return pagado;
  }

  Future<void> _seleccionarFecha() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaPago,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'Selecciona la fecha del pago',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (fecha == null) {
      return;
    }

    setState(() {
      _fechaPago = DateTime(
        fecha.year,
        fecha.month,
        fecha.day,
        _fechaPago.hour,
        _fechaPago.minute,
      );
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

    final deuda = _deudaSeleccionada;

    if (deuda == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar una deuda válida.')),
      );
      return;
    }

    final valor = double.parse(
      _valorController.text.trim().replaceAll(',', '.'),
    );

    if (valor <= 0) {
      return;
    }

    final esDeudaProgramadaConCuotas = deuda.programada && deuda.tieneCuotas;

    if (esDeudaProgramadaConCuotas && _cuotasSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar al menos una cuota.')),
      );
      return;
    }

    if (!esDeudaProgramadaConCuotas &&
        _tipoPago == TipoPago.capital &&
        deuda.tieneCuotas &&
        _cuotasSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar al menos una cuota.')),
      );
      return;
    }

    if (!esDeudaProgramadaConCuotas &&
        _tipoPago == TipoPago.interes &&
        _interesSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe seleccionar un período de interés.'),
        ),
      );
      return;
    }

    if (valor > _saldoDisponible) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'El valor no puede superar '
            'el saldo disponible de ${AppConstants.formatearMoneda(_saldoDisponible)}.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _guardando = true;
    });
    try {
      final notifier = ref.read(pagoProvider.notifier);
      final pago = widget.pago ?? Pago();
      pago.valor = valor;
      pago.fechaPago = _fechaPago;
      pago.metodoPago = _metodoPago;
      pago.tipoPago = _tipoPago;
      pago.referencia = _limpiarTexto(_referenciaController.text);
      pago.observacion = _limpiarTexto(_observacionController.text);
      pago.fechaActualizacion = DateTime.now();
      pago.eliminado = false;
      final esDeudaProgramadaConCuotas = deuda.programada && deuda.tieneCuotas;

      pago.deuda.value = deuda;

      if (esDeudaProgramadaConCuotas) {
        // Para una deuda programada con cuotas el pago
        // representa una reducción de la obligación total.
        //
        // Internamente conservamos TipoPago.capital para
        // mantener compatibilidad con el modelo actual.
        pago.tipoPago = TipoPago.capital;
        pago.interes.value = null;

        pago.cuotas
          ..clear()
          ..addAll(_cuotasSeleccionadas);
      } else if (_tipoPago == TipoPago.capital) {
        pago.interes.value = null;

        if (deuda.tieneCuotas) {
          pago.cuotas
            ..clear()
            ..addAll(_cuotasSeleccionadas);
        } else {
          pago.cuotas.clear();
        }
      } else {
        pago.cuotas.clear();
        pago.interes.value = _interesSeleccionado;
      }
      debugPrint(
        'CUOTAS SELECCIONADAS EN FORMULARIO: '
        '${_cuotasSeleccionadas.map((c) => c.id).toList()}',
      );

      debugPrint(
        'CUOTAS EN PAGO ANTES DE REGISTRAR: '
        '${pago.cuotas.map((c) => c.id).toList()}',
      );
      if (widget.isEditing) {
        await notifier.actualizar(pago);
      } else {
        await notifier.registrar(
          pago,
          cuotasSeleccionadas: _cuotasSeleccionadas,
        );
      }
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Pago actualizado correctamente.'
                : 'Pago registrado correctamente.',
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e, stackTrace) {
      debugPrint(
        widget.isEditing
            ? 'ERROR AL ACTUALIZAR PAGO: $e'
            : 'ERROR AL REGISTRAR PAGO: $e',
      );
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // widget.isEditing
            //     ? 'No se pudo actualizar el pago.'
            //     : 'No se pudo registrar el pago.',
            '${widget.isEditing ? 'No se pudo actualizar el pago' : 'No se pudo registrar el pago'}: $e',
          ),
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

  String? _limpiarTexto(String value) {
    final texto = value.trim();

    return texto.isEmpty ? null : texto;
  }

  Widget _buildDeudaAutocomplete(BuildContext context) {
    return Autocomplete<Deuda>(
      displayStringForOption: (deuda) {
        final cliente = deuda.cliente.value;
        return cliente?.nombre ?? 'Cliente desconocido';
      },

      initialValue: TextEditingValue(
        text: _deudaSeleccionadaActual != null
            ? _nombreDeuda(_deudaSeleccionadaActual!)
            : '',
      ),

      optionsBuilder: (TextEditingValue textEditingValue) {
        final texto = textEditingValue.text.trim().toLowerCase();

        if (texto.isEmpty) {
          return widget.deudas;
        }

        return widget.deudas.where((deuda) {
          final cliente = deuda.cliente.value;

          final nombreCliente = cliente?.nombre.toLowerCase() ?? '';

          final total = deuda.total.toStringAsFixed(0);

          final saldo = deuda.saldoPendiente.toStringAsFixed(0);

          return nombreCliente.contains(texto) ||
              total.contains(texto) ||
              saldo.contains(texto);
        });
      },

      onSelected: (Deuda deuda) async {
        setState(() {
          _deudaSeleccionadaActual = deuda;
          _cuotasSeleccionadas.clear();
          _interesSeleccionado = null;
        });

        await _cargarConceptosDeuda(deuda);
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
                labelText: 'Seleccionar deuda',
                hintText: 'Buscar por cliente o valor...',
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                border: OutlineInputBorder(),
              ),

              validator: (_) {
                if (_deudaSeleccionadaActual == null) {
                  return 'Selecciona una deuda';
                }

                return null;
              },

              onChanged: (texto) {
                if (_deudaSeleccionadaActual != null &&
                    texto != _nombreDeuda(_deudaSeleccionadaActual!)) {
                  setState(() {
                    _deudaSeleccionadaActual = null;
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
            AutocompleteOnSelected<Deuda> onSelected,
            Iterable<Deuda> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final deuda = options.elementAt(index);

                      final cliente = deuda.cliente.value;

                      final nombreCliente =
                          cliente?.nombre ?? 'Cliente desconocido';

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.account_balance_wallet_outlined),
                        ),

                        title: Text(
                          nombreCliente,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        subtitle: Text(
                          'Total: ${AppConstants.formatearMoneda(deuda.total)}'
                          ' · Saldo: ${AppConstants.formatearMoneda(deuda.saldoPendiente)}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        trailing: deuda.estado == EstadoDeuda.pagada
                            ? const Icon(Icons.check_circle_outline)
                            : const Icon(Icons.chevron_right),

                        onTap: () {
                          onSelected(deuda);
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

  Widget _buildTipoPagoSelector(BuildContext context) {
    final deuda = _deudaSeleccionada;

    if (deuda?.programada == true && deuda?.tieneCuotas == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipo de pago',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.payments_outlined),
                SizedBox(width: 12),
                Expanded(child: Text('Pago contra deuda programada')),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de pago',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SegmentedButton<TipoPago>(
          segments: const [
            ButtonSegment<TipoPago>(
              value: TipoPago.capital,
              icon: Icon(Icons.account_balance_outlined),
              label: Text('Capital'),
            ),
            ButtonSegment<TipoPago>(
              value: TipoPago.interes,
              icon: Icon(Icons.percent_outlined),
              label: Text('Interés'),
            ),
          ],
          selected: {_tipoPago},
          onSelectionChanged: _guardando
              ? null
              : (seleccion) async {
                  if (seleccion.isEmpty) {
                    return;
                  }

                  final tipo = seleccion.first;

                  setState(() {
                    _tipoPago = tipo;
                    _cuotasSeleccionadas.clear();
                    _interesSeleccionado = null;
                  });

                  final deuda = _deudaSeleccionada;

                  if (deuda != null) {
                    await _cargarConceptosDeuda(deuda);
                  }
                },
        ),
      ],
    );
  }

  Widget _buildCuotasSection(BuildContext context) {
    if (_cargandoConceptos) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_cuotasDisponibles.isEmpty) {
      return const Text('No existen cuotas disponibles para esta deuda.');
    }
    final cantidadSeleccionada = _cuotasSeleccionadas.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuotas',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _guardando ? null : () => _mostrarSelectorCuotas(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Cuotas a pagar',
              prefixIcon: const Icon(Icons.payments_outlined),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: const OutlineInputBorder(),
              enabled: !_guardando,
            ),
            child: Text(
              cantidadSeleccionada == 0
                  ? 'Seleccionar cuotas'
                  : cantidadSeleccionada == 1
                  ? '1 cuota seleccionada'
                  : '$cantidadSeleccionada cuotas seleccionadas',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        if (cantidadSeleccionada > 0) ...[
          const SizedBox(height: 6),
          Text(
            _textoCuotasSeleccionadas(),
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Future<void> _mostrarSelectorCuotas(BuildContext context) async {
    final seleccionadas = List<CuotaDeuda>.from(_cuotasSeleccionadas);

    final resultado = await showDialog<List<CuotaDeuda>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Seleccionar cuotas'),
              content: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.55,
                child: ListView.builder(
                  itemCount: _cuotasDisponibles.length,
                  itemBuilder: (context, index) {
                    final cuota = _cuotasDisponibles[index];
                    final saldo = cuota.saldoPendiente;

                    final seleccionada = seleccionadas.any(
                      (item) => item.id == cuota.id,
                    );

                    return CheckboxListTile(
                      value: seleccionada,
                      enabled: saldo > 0,
                      onChanged: saldo <= 0
                          ? null
                          : (seleccionar) {
                              setDialogState(() {
                                if (seleccionar == true) {
                                  if (!seleccionadas.any(
                                    (item) => item.id == cuota.id,
                                  )) {
                                    seleccionadas.add(cuota);
                                  }
                                } else {
                                  seleccionadas.removeWhere(
                                    (item) => item.id == cuota.id,
                                  );
                                }
                              });
                            },
                      title: Text(
                        'Cuota ${cuota.numeroCuota}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Valor: ${AppConstants.formatearMoneda(cuota.valor)}'
                        ' · Pagado: ${AppConstants.formatearMoneda(cuota.valorPagado)}'
                        ' · Saldo: ${AppConstants.formatearMoneda(saldo)}',
                      ),
                      secondary: _buildEstadoCuota(cuota.estado),
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('CANCELAR'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(seleccionadas);
                  },
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          },
        );
      },
    );

    if (resultado == null || !mounted) {
      return;
    }

    setState(() {
      _cuotasSeleccionadas
        ..clear()
        ..addAll(resultado);
    });
  }

  String _textoCuotasSeleccionadas() {
    if (_cuotasSeleccionadas.isEmpty) {
      return '';
    }

    final numeros =
        _cuotasSeleccionadas.map((cuota) => cuota.numeroCuota).toList()..sort();

    if (numeros.length <= 3) {
      return 'Seleccionadas: ${numeros.map((n) => 'Cuota $n').join(', ')}';
    }

    return 'Seleccionadas: Cuotas ${numeros.join(', ')}';
  }

  Widget _buildEstadoCuota(EstadoCuota estado) {
    switch (estado) {
      case EstadoCuota.pendiente:
        return const Icon(Icons.radio_button_unchecked);

      case EstadoCuota.parcial:
        return const Icon(Icons.timelapse);

      case EstadoCuota.pagada:
        return const Icon(Icons.check_circle_outline);
    }
  }

  Widget _buildInteresSection(BuildContext context) {
    if (_cargandoConceptos) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_interesesDisponibles.isEmpty) {
      return const Text(
        'No existen períodos de interés disponibles para esta deuda.',
      );
    }

    return DropdownButtonFormField<InteresDeuda>(
      initialValue: _interesSeleccionado,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Período de interés',
        prefixIcon: Icon(Icons.percent_outlined),
        border: OutlineInputBorder(),
      ),
      items: _interesesDisponibles.map((interes) {
        return DropdownMenuItem<InteresDeuda>(
          value: interes,
          child: Text(
            'Período ${interes.numeroPeriodo} · '
            'Saldo: ${AppConstants.formatearMoneda(interes.saldoPendiente)}',
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: _guardando
          ? null
          : (interes) {
              setState(() {
                _interesSeleccionado = interes;
              });
            },
      validator: (_) {
        if (_tipoPago == TipoPago.interes && _interesSeleccionado == null) {
          return 'Selecciona un período de interés';
        }

        return null;
      },
    );
  }
}

class _ResumenDeudaCard extends StatelessWidget {
  const _ResumenDeudaCard({
    required this.deuda,
    required this.saldoDisponible,
    required this.tipoPago,
  });

  final Deuda deuda;
  final double saldoDisponible;
  final TipoPago tipoPago;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cliente = deuda.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente no encontrado';

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen de la deuda',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              nombreCliente,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ResumenItem(
                    titulo: 'Total',
                    valor: AppConstants.formatearMoneda(deuda.total),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ResumenItem(
                    titulo: tipoPago == TipoPago.capital
                        ? 'Saldo de capital'
                        : 'Saldo de interés',
                    valor: AppConstants.formatearMoneda(saldoDisponible),
                    destacado: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
