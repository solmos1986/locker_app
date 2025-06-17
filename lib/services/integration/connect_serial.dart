import 'dart:developer';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/utils/get_log_reponse.dart';

class ConnectSerial {
  FlutterSerial flutterSerial = FlutterSerial();
  final getLogReponse = GetLogReponse();
  String comand = "";
  String comandResponse = "";
  ConnectSerial() {
    log("ConnectSerial");
    getPorts();
    //inizialize();
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
    final value = getLogReponse.getLogsResponse(result!.readChannel!);
    log("ConnectSerial result $value");
  }

  Future<void> setMessage(String code) async {
    log("ConnectSerial setMessage($comand)");
    final result = await flutterSerial.sendCommand(message: code);
    log("ConnectSerial result ${result!}");
    await flutterSerial.clearLog();
    await flutterSerial.clearRead();
    flutterSerial.closePort();
  }

  Future<void> closePort() async {
    log("ConnectSerial closePort()");
    await flutterSerial.closePort();
  }

  ////////get listen/////////
  Stream<SerialResponse> getListenSerial() {
    log("ConnectSerial getListenSerial()");
    return flutterSerial.startSerial().take(1);
  }

  //strema fake
  Stream<int> getListenSerialFake() {
    log("ConnectSerial getListenSerial()");
    return Stream.periodic(const Duration(seconds: 1), (value) {
      return value;
    }).take(5);
  }
}
