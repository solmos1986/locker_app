import 'dart:developer';
import 'package:flutter_serial/flutter_serial.dart';

class ConnectSerial {
  FlutterSerial flutterSerial = FlutterSerial();

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
    flutterSerial.startSerial().listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(SerialResponse? result) {
    /* log("logChannel ${result!.logChannel}"); */
    log("ConnectSerial _updateConnectionStatus ${result!.readChannel ?? ""}");
  }

  Future<void> setMessage(String code) async {
    log("ConnectSerial setMessage($code)");
    await flutterSerial.clearLog();
    await flutterSerial.clearRead();
    await flutterSerial.closePort();
    final result = await flutterSerial.sendCommand(message: code);
    log("ConnectSerial result ${result!}");

    //flutterSerial.closePort();
  }

  Future<void> closePort() async {
    log("ConnectSerial closePort()");
    await flutterSerial.closePort();
  }
}
