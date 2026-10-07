import 'package:flutter_deudas_pro_app/models/configuracion.dart';
import 'package:flutter_deudas_pro_app/models/deuda.dart';
import 'package:timezone/timezone.dart' as tz;

import 'notification_constants.dart';
import 'notification_service.dart';

class DeudaNotificationService {
  DeudaNotificationService._();

  static final DeudaNotificationService instance = DeudaNotificationService._();

  final NotificationService _notificationService = NotificationService.instance;

  /// Programa todas las notificaciones correspondientes a una deuda.
  ///
  /// Se generan:
  /// - Recordatorio anticipado.
  /// - Aviso el día del vencimiento.
  /// - Aviso de deuda vencida, cuando corresponde.
  Future<void> programarParaDeuda({
    required Deuda deuda,
    required Configuracion configuracion,
  }) async {
    final idAnticipada = NotificationConstants.deudaAnticipada(deuda.id);
    final idVenceHoy = NotificationConstants.deudaVenceHoy(deuda.id);
    final idVencida = NotificationConstants.deudaVencida(deuda.id);

    // Si la deuda no debe generar recordatorios, cancelar los existentes.
    if (!configuracion.notificacionesActivas ||
        deuda.archivada ||
        deuda.saldoPendiente <= 0 ||
        deuda.fechaVencimiento == null) {
      await cancelarParaDeuda(deuda.id);
      return;
    }

    final fechaVencimiento = deuda.fechaVencimiento!;
    final ahora = tz.TZDateTime.now(tz.local);
    final hora = configuracion.horaNotificacion;
    final minuto = configuracion.minutoNotificacion;

    // 1. Recordatorio anticipado.
    if (configuracion.diasAnticipacion > 0) {
      final fechaAnticipada = fechaVencimiento.subtract(
        Duration(days: configuracion.diasAnticipacion),
      );

      final notificacionAnticipada = tz.TZDateTime(
        tz.local,
        fechaAnticipada.year,
        fechaAnticipada.month,
        fechaAnticipada.day,
        hora,
        minuto,
      );

      if (notificacionAnticipada.isAfter(ahora)) {
        await _notificationService.schedule(
          id: idAnticipada,
          title: 'Deuda próxima a vencer',
          body: _mensajeDeuda(deuda),
          scheduledDate: notificacionAnticipada,
        );
      } else {
        await _notificationService.cancel(idAnticipada);
      }
    } else {
      await _notificationService.cancel(idAnticipada);
    }

    // 2. Recordatorio del día del vencimiento.
    final notificacionVencimiento = tz.TZDateTime(
      tz.local,
      fechaVencimiento.year,
      fechaVencimiento.month,
      fechaVencimiento.day,
      hora,
      minuto,
    );

    if (notificacionVencimiento.isAfter(ahora)) {
      await _notificationService.schedule(
        id: idVenceHoy,
        title: 'Deuda vence hoy',
        body: _mensajeDeuda(deuda),
        scheduledDate: notificacionVencimiento,
      );
    } else {
      await _notificationService.cancel(idVenceHoy);
    }

    // 3. Recordatorio para deudas vencidas.
    if (configuracion.notificarDeudasVencidas &&
        _esFechaAnteriorAlDia(fechaVencimiento, ahora)) {
      // Programar el próximo aviso a la hora configurada.
      // Si esa hora ya pasó hoy, se programa para mañana.
      var proximoAviso = tz.TZDateTime(
        tz.local,
        ahora.year,
        ahora.month,
        ahora.day,
        hora,
        minuto,
      );

      if (!proximoAviso.isAfter(ahora)) {
        proximoAviso = proximoAviso.add(const Duration(days: 1));
      }

      await _notificationService.schedule(
        id: idVencida,
        title: 'Deuda vencida',
        body: _mensajeDeuda(deuda),
        scheduledDate: proximoAviso,
      );
    } else {
      await _notificationService.cancel(idVencida);
    }
  }

  /// Cancela todas las notificaciones programadas para una deuda.
  Future<void> cancelarParaDeuda(int deudaId) async {
    await _notificationService.cancel(
      NotificationConstants.deudaAnticipada(deudaId),
    );

    await _notificationService.cancel(
      NotificationConstants.deudaVenceHoy(deudaId),
    );

    await _notificationService.cancel(
      NotificationConstants.deudaVencida(deudaId),
    );
  }

  /// Sincroniza las notificaciones de una lista completa de deudas.
  ///
  /// Las notificaciones anteriores se cancelan primero para evitar
  /// que queden avisos correspondientes a datos que ya cambiaron.
  Future<void> sincronizar({
    required List<Deuda> deudas,
    required Configuracion configuracion,
  }) async {
    for (final deuda in deudas) {
      await programarParaDeuda(deuda: deuda, configuracion: configuracion);
    }
  }

  /// Cancela las notificaciones de varias deudas.
  Future<void> cancelarParaDeudas(List<Deuda> deudas) async {
    for (final deuda in deudas) {
      await cancelarParaDeuda(deuda.id);
    }
  }

  String _mensajeDeuda(Deuda deuda) {
    final cliente = deuda.cliente.value;

    final nombreCliente = cliente?.nombre.trim();

    if (nombreCliente != null && nombreCliente.isNotEmpty) {
      return 'Cliente: $nombreCliente. '
          'Saldo pendiente: ${deuda.saldoPendiente.toStringAsFixed(2)}.';
    }

    return 'Saldo pendiente: '
        '${deuda.saldoPendiente.toStringAsFixed(2)}.';
  }

  bool _esFechaAnteriorAlDia(DateTime fecha, DateTime referencia) {
    final fechaDia = DateTime(fecha.year, fecha.month, fecha.day);

    final referenciaDia = DateTime(
      referencia.year,
      referencia.month,
      referencia.day,
    );

    return fechaDia.isBefore(referenciaDia);
  }
}
