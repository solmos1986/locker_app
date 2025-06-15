import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_serial/flutter_serial.dart';

class ConnectSerial {
  FlutterSerial flutterSerial = FlutterSerial();
  String comand = "";
  String comandResponse = "";
  ConnectSerial() {
    log("ConnectSerial");

    getPorts();
    inizialize();
  }

  Future<void> getPorts() async {
    log("ConnectSerial getPorts()");
    await flutterSerial.getAvailablePorts();

    await flutterSerial.openPort(
      dataFormat: DataFormat.HEX_STRING,
      serialPort: '/dev/ttyS0',
      baudRate: 9600,
    );
  }

  Future<void> inizialize() async {
    log("ConnectSerial inizialize()");
    flutterSerial.startSerial().listen(_updateConnectionStatus);
    //flutterSerial.startSerial().listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(SerialResponse? result) {
    /* log("logChannel ${result!.logChannel}"); */
    //log("ConnectSerial escuchando.. ${result!.readChannel ?? ""}");

    final logs =
        result!.readChannel!
            //.replaceAll("\n", "-")
            .split("\n")
            .map((String text) => text)
            .toList();

    /*  for (var val in logs) {
      log("ConnectSerial escuchando.. $val");
    } */

    if (logs.length > 1) {
      final value = logs[logs.length - 2];

      final nuevo = value.replaceAll("/dev/ttyS0/hex read：", "");
      comandResponse = nuevo;
      log("ultimo valor $nuevo");
    }
  }

  Future<void> setMessage(String code) async {
    //log("ConnectSerial setMessage($code)");
    log("ConnectSerial setMessage($comand)");
    //await flutterSerial.clearLog();
    //await flutterSerial.clearRead();
    //await flutterSerial.closePort();
    final result = await flutterSerial.sendCommand(message: comand);
    log("ConnectSerial result ${result!}");
    await flutterSerial.clearLog();
    await flutterSerial.clearRead();
    flutterSerial.closePort();
  }

  Future<void> closePort() async {
    log("ConnectSerial closePort()");
    await flutterSerial.closePort();
  }
}
