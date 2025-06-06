import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_serial_communication/flutter_serial_communication.dart';
import 'package:flutter_serial_communication/models/device_info.dart';

class ConectionSerialTest2 {
  ConectionSerialTest2() {
    log('class ConectionSerialTest2');
  }

  final _flutterSerialCommunicationPlugin = FlutterSerialCommunication();

  Future<void> inizialize() async {
    List<DeviceInfo> availableDevices =
        await _flutterSerialCommunicationPlugin.getAvailableDevices();
    for (var device in availableDevices) {
      log('deviceName ${device.deviceName} deviceId ${device.deviceId}');
      log('serialNumber ${device.serialNumber} productName ${device.productName}');
    }
  }

  Future<void> sendMessage() async {
    //8A 01 01 11 9B
    final valor=Uint8List.fromList([0x8A, 0x01, 0x01, 0x11, 0x9B]);
    convert(valor);
    DeviceInfo device = DeviceInfo();
    int baudRate = 0;
    bool isConnectionSuccess = await _flutterSerialCommunicationPlugin.connect(
      device,
      baudRate,
    );

    log("isConnectionSuccess: ${isConnectionSuccess.toString()}");
    bool isMessageSent = await _flutterSerialCommunicationPlugin.write(
      Uint8List.fromList(valor),
    );
    log("Is Message Sent:  $isMessageSent");
  }

  void convert(Uint8List uint8List) {
    Uint8List bytes = Uint8List.fromList(uint8List);
    log("convert:  $bytes");
  }
}
