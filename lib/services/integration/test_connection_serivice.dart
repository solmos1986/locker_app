import 'dart:developer';

import 'package:flutter_serial/flutter_serial.dart';

class ConectionSerial {
  FlutterSerial flutterSerial = FlutterSerial();

  ConectionSerial() {
    log("clase ConectionSerial");

    getPorts();
    inizialize();
  }

  Future<void> getPorts() async {
    log(" inicializadando getAvailablePorts");
    await flutterSerial.getAvailablePorts();

    await flutterSerial.openPort(
      dataFormat: DataFormat.HEX_STRING,
      serialPort: '/dev/ttyS0',
      baudRate: 9600,
    );
    /*  if (serialList!.isNotEmpty) {
      serialList.forEach((a) {
        log(' serialList  $a');
      });
    } else {
      log('serialList esta en blanco');
    } */
  }

  Future<void> inizialize() async {
    log("inizialize listen");

    flutterSerial.startSerial().listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(SerialResponse? result) {
    /* log("logChannel ${result!.logChannel}"); */
    log("readChannel ${result!.readChannel ?? ""}");
  }

  Future<void> setMessage() async {
    log(" inicializadando setMessage");
    await flutterSerial.clearLog();
    await flutterSerial.clearRead();
    await flutterSerial.closePort();
    final result = await flutterSerial.sendCommand(message: "80010633b4");
    log(" result message ${result!}");
  }
}
