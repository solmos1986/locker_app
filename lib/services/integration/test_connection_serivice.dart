import 'dart:developer';

import 'package:flutter_serial/flutter_serial.dart';

class ConectionSerial {
  FlutterSerial flutterSerial = FlutterSerial();
  ConectionSerial() {
    log("clase ConectionSerial");
  }

  Future<void> getPorts() async {
    log(" inicializadando getAvailablePorts");
    final serialList = await flutterSerial.getAvailablePorts();

    if (serialList!.isNotEmpty) {
      serialList.forEach((a) {
        log(' serialList  $a');
      });
    } else {
      log('serialList esta en blanco');
    }
  }

  void inizialize() {
    flutterSerial.startSerial().listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(SerialResponse? result) async {
    log("data ${result!.logChannel ?? ""}");
    log("data ${result.readChannel ?? ""}");
  }

  Future<void> setMessage() async {
    log(" inicializadando setMessage");
    FlutterSerial flutterSerial = FlutterSerial();

    await flutterSerial.openPort(
      dataFormat: DataFormat.HEX_STRING,
      serialPort: '/dev/ttyS0',
      baudRate: 9600,
    );

    final result = await flutterSerial.sendCommand(message: "8A 01 01 11 9B");
    log(" inicializadando result ${result.toString()}");

    //flutterSerial.closePort();
  }
}
