import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/config/navigator_key.dart';
import 'package:locker_app/infrastructure/models/open_door.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/services/socket_service.dart';
import 'package:locker_app/utils/get_log_reponse.dart';
import 'package:provider/provider.dart';

/// Se inicializa una vez en `main()`. Escucha los eventos `open-door` que
/// llegan por Socket.IO y abre la puerta por el puerto serial, aunque el
/// usuario esté navegando en otra pantalla.
///
/// Equivalente a `UtilRabbtiMqProvider` pero sobre Socket.IO.
class UtilSocketProvider {
  UtilSocketProvider._internal();
  static final UtilSocketProvider instance = UtilSocketProvider._internal();

  final connectSerial = ConnectSerial();
  final getLogReponse = GetLogReponse();
  final requestComandRepository = RequestComandRepository();

  StreamSubscription<Map<String, dynamic>>? _subscription;

  /// Abre la conexión (si no está abierta) y empieza a procesar eventos.
  void listen() {
    SocketService.instance.connect();
    _subscription ??= SocketService.instance.onOpenDoor.listen(_onOpenDoor);
  }

  Future<void> _onOpenDoor(Map<String, dynamic> data) async {
    try {
      final openDoor = OpenDoorModel.fromJson(data);
      log('UtilSocketProvider abrir puerta: ${openDoor.doorId}');

      final comands = await requestComandRepository.getCodeForDoor(
        openDoor.doorId,
        'abrir',
      );
      if (comands.isEmpty) {
        log('UtilSocketProvider: sin comandos para la puerta ${openDoor.doorId}');
        return;
      }

      connectSerial.getListenSerial().listen((SerialResponse? result) async {
        final value = getLogReponse.getLogsResponse(result?.readChannel ?? '');
        if (value == comands.first.responseComand) {
          log('UtilSocketProvider codigo enviado para abrir');
        }
      });

      connectSerial.sendMessage(comands.first.requestComand);
    } catch (e) {
      log('UtilSocketProvider error: ${e.toString()}');
    }
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}

/// Se inicializa una vez en `main()`. Escucha los eventos `update_data` que
/// llegan por Socket.IO y resincroniza la base de datos local invocando
/// `ConfigProvider.getDataBase()` (el mismo método que dispara el botón
/// "Actualizar database" de `ConfigScreen`), sin importar en qué pantalla
/// esté el usuario.
class UtilUpdateDataProvider {
  UtilUpdateDataProvider._internal();
  static final UtilUpdateDataProvider instance =
      UtilUpdateDataProvider._internal();

  StreamSubscription<void>? _subscription;

  /// Abre la conexión (si no está abierta) y empieza a procesar eventos.
  void listen() {
    SocketService.instance.connect();
    _subscription ??= SocketService.instance.onUpdateData.listen(
      (_) => _onUpdateData(),
    );
  }

  Future<void> _onUpdateData() async {
    final context = navigatorKey.currentContext;
    if (context == null) {
      log('UtilUpdateDataProvider: sin context, no se puede actualizar la base');
      return;
    }
    try {
      log('UtilUpdateDataProvider: actualizando base de datos por socket');
      await context.read<ConfigProvider>().getDataBase();
    } catch (e) {
      log('UtilUpdateDataProvider error: ${e.toString()}');
    }
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}

/// Estado de conexión de Socket.IO para la UI. Registrar en el `MultiProvider`
/// raíz para que cualquier pantalla pueda mostrar el indicador de conexión.
class SocketProvider extends ChangeNotifier {
  bool connected = SocketService.instance.isConnected;
  late final StreamSubscription<bool> _subscription;

  SocketProvider() {
    _subscription = SocketService.instance.onStatusChange.listen((value) {
      connected = value;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
