import 'dart:async';
import 'dart:developer';

import 'package:locker_app/helper/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// Conexión Socket.IO única para toda la app.
///
/// Se conecta una sola vez desde `main()` y permanece viva mientras la app
/// esté abierta, sin importar la navegación entre pantallas. Las pantallas
/// solo se suscriben a los streams; nunca abren ni cierran la conexión.
class SocketService {
  SocketService._internal();
  static final SocketService instance = SocketService._internal();

  io.Socket? _socket;

  final _openDoorController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _statusController = StreamController<bool>.broadcast();
  final _updateDataController = StreamController<void>.broadcast();

  /// Eventos `open-door` recibidos del servidor.
  Stream<Map<String, dynamic>> get onOpenDoor => _openDoorController.stream;

  /// Cambios de estado de conexión (true = conectado).
  Stream<bool> get onStatusChange => _statusController.stream;

  /// Eventos `update_data` recibidos del servidor (aviso de que hay que
  /// resincronizar la base de datos local).
  Stream<void> get onUpdateData => _updateDataController.stream;

  bool get isConnected => _socket?.connected ?? false;

  void connect() {
    log('SocketService connect urlSocketIo ${EnvConfig.urlSocketIo}');
    if (_socket != null) return; // ya inicializado

    log('SocketService connect ${EnvConfig.urlSocketIo}');
    _socket = io.io(
      EnvConfig.urlSocketIo,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(2000)
          .setReconnectionDelayMax(10000)
          /* .setAuth({'token': EnvConfig.token})
          .setQuery({'locker_id': EnvConfig.lockerId}) */
          .build(),
    );

    _socket!
      ..onConnect((_) {
        log('SocketService conectado: ${_socket!.id}');
        _statusController.add(true);
        _socket!.emit('join', {
          'locker_id': EnvConfig.lockerId,
          'building_id': EnvConfig.buildingId,
        });
      })
      ..onDisconnect((_) {
        log('SocketService desconectado');
        _statusController.add(false);
      })
      ..onConnectError((e) => log('SocketService connect_error: $e'))
      ..onError((e) => log('SocketService error: $e'))
      ..on('door', (data) {
        log('door message: $data');
        if (data is Map) {
          _openDoorController.add(Map<String, dynamic>.from(data));
        }
      })
      ..on('update_data', (data) {
        log('Update data base message: $data');
        _updateDataController.add(null);
      });

    _socket!.connect();
  }

  /// Reintenta la conexión manualmente (p. ej. al volver de segundo plano).
  void reconnect() {
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
    }
  }

  void emit(String event, dynamic data) => _socket?.emit(event, data);

  void dispose() {
    _socket?.dispose();
    _socket = null;
    _openDoorController.close();
    _statusController.close();
    _updateDataController.close();
  }
}
