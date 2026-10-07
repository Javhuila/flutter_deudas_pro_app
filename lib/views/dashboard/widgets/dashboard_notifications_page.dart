import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/configuracion.dart';
import '../../../models/deuda.dart';
import '../../../providers/configuracion_provider.dart';
import '../../../providers/deuda_provider.dart';

class DashboardNotificacionsPage extends ConsumerWidget {
  const DashboardNotificacionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deudaService = ref.read(deudaServiceProvider);
    final configuracionService = ref.read(configuracionServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            deudaService.obtenerTodas(),
            configuracionService.obtener(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomScrollView(
                slivers: [
                  _construirAppBar(),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  _construirAppBar(),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline_rounded, size: 48),
                            const SizedBox(height: 12),
                            const Text(
                              'No se pudieron cargar las notificaciones.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            FilledButton(
                              onPressed: () {
                                // La pantalla puede volver a consultarse
                                // al salir y entrar nuevamente.
                                Navigator.of(context).pop();
                              },
                              child: const Text('Volver'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            final deudas = snapshot.data![0] as List<Deuda>;
            final configuracion = snapshot.data![1] as Configuracion;

            final avisos = _obtenerAvisos(
              deudas: deudas,
              configuracion: configuracion,
            );

            return RefreshIndicator(
              onRefresh: () async {
                // FutureBuilder volverá a consultar al reconstruirse.
                // Para actualizar manualmente, salir y volver a entrar.
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _construirAppBar(),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        avisos.isEmpty
                            ? 'No tienes avisos pendientes.'
                            : '${avisos.length} '
                                  '${avisos.length == 1 ? 'aviso' : 'avisos'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),

                  if (avisos.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.notifications_off_outlined, size: 56),
                              SizedBox(height: 16),
                              Text(
                                'Todo al día',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Cuando haya deudas próximas a vencer '
                                'o vencidas, aparecerán aquí.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final aviso = avisos[index];

                          return _AvisoCard(aviso: aviso);
                        }, childCount: avisos.length),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _construirAppBar() {
    return const SliverAppBar(
      pinned: true,
      floating: true,
      title: Text('Notificaciones'),
    );
  }

  List<_AvisoDeuda> _obtenerAvisos({
    required List<Deuda> deudas,
    required Configuracion configuracion,
  }) {
    if (!configuracion.notificacionesActivas) {
      return [];
    }

    final ahora = DateTime.now();
    final hoy = DateTime(ahora.year, ahora.month, ahora.day);

    final avisos = <_AvisoDeuda>[];

    for (final deuda in deudas) {
      if (deuda.archivada || deuda.saldoPendiente <= 0) {
        continue;
      }

      final vencimiento = deuda.fechaVencimiento;
      if (vencimiento == null) {
        continue;
      }

      final fechaVencimiento = DateTime(
        vencimiento.year,
        vencimiento.month,
        vencimiento.day,
      );

      final diasRestantes = fechaVencimiento.difference(hoy).inDays;

      if (diasRestantes < 0 && configuracion.notificarDeudasVencidas) {
        avisos.add(
          _AvisoDeuda(
            deuda: deuda,
            titulo: 'Deuda vencida',
            descripcion: 'Esta deuda tiene un vencimiento anterior a hoy.',
            prioridad: 0,
          ),
        );
      } else if (diasRestantes == 0) {
        avisos.add(
          _AvisoDeuda(
            deuda: deuda,
            titulo: 'Deuda vence hoy',
            descripcion: 'La fecha de vencimiento es hoy.',
            prioridad: 1,
          ),
        );
      } else if (configuracion.diasAnticipacion > 0 &&
          diasRestantes <= configuracion.diasAnticipacion) {
        avisos.add(
          _AvisoDeuda(
            deuda: deuda,
            titulo: 'Deuda próxima a vencer',
            descripcion: diasRestantes == 1
                ? 'Vence mañana.'
                : 'Vence dentro de $diasRestantes días.',
            prioridad: 2,
          ),
        );
      }
    }

    avisos.sort((a, b) {
      final prioridad = a.prioridad.compareTo(b.prioridad);

      if (prioridad != 0) {
        return prioridad;
      }

      return a.deuda.fechaVencimiento!.compareTo(b.deuda.fechaVencimiento!);
    });

    return avisos;
  }
}

class _AvisoDeuda {
  const _AvisoDeuda({
    required this.deuda,
    required this.titulo,
    required this.descripcion,
    required this.prioridad,
  });

  final Deuda deuda;
  final String titulo;
  final String descripcion;
  final int prioridad;
}

class _AvisoCard extends StatelessWidget {
  const _AvisoCard({required this.aviso});

  final _AvisoDeuda aviso;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cliente = aviso.deuda.cliente.value;
    final nombreCliente = cliente?.nombre.trim();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              aviso.prioridad == 0
                  ? Icons.warning_amber_rounded
                  : aviso.prioridad == 1
                  ? Icons.event_busy_rounded
                  : Icons.notifications_active_outlined,
              color: aviso.prioridad == 0
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(aviso.titulo, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    nombreCliente == null || nombreCliente.isEmpty
                        ? 'Cliente no disponible'
                        : nombreCliente,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(aviso.descripcion),
                  const SizedBox(height: 8),
                  Text(
                    'Saldo pendiente: '
                    '${aviso.deuda.saldoPendiente.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
