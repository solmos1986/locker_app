import 'dart:developer';
import 'dart:typed_data';

import 'package:libserialport/libserialport.dart';

class Test3 {
  void inxiaalize() {
    final name = SerialPort.availablePorts.first;
    log(' name ${name.toString()}');
    final port = SerialPort("/dev/ttyS0");
    if (!port.openReadWrite()) {
      //port.config()
      print(SerialPort.lastError);
      //exit(-1);
    }

    port.write(Uint8List.fromList("8a0101119b".codeUnits));

    final reader = SerialPortReader(port);
    reader.stream.listen((data) {
      print('received: $data');
    });
  }
}
