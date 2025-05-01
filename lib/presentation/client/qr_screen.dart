import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locker_app/presentation/client/confirmate_screen.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  bool authenticado = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    /* Future.delayed(const Duration(seconds: 5)).then((val) {
      Navigator.pop(context, false);
    }); */

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        authenticado = true;
        result = scanData;
        if (result != null) {
          controller.disposed = true;
          if (result != null) {
            controller.stopCamera();
            log('cambio detectado codigo ${result!.code.toString()}');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmateScreen(
                        user: result!.code.toString(),
                      )),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Enfoca el QR'),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Expanded(
          flex: 6,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: (result != null)
                ? Text(
                    'Barcode Type:  ${result!.format.toString()}  Data: ${result!.code} Validate: ${authenticado.toString()}')
                : Text('Scan a code '),
          ),
        )
      ]),
    );
  }
}
