import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/presentation/provider/verified_code_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

/* class QrScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    final verifiedCodeProvider = context.watch<VerifiedCodeProvider>();

    void navigateConfirmate(VerifiedCodeModel verifiedcode) {
      Navigator.pushNamed(
        context,
        '/confirm-reception',
        arguments: verifiedcode,
      );
    }

    void navigateRetry() {
      Navigator.pushNamed(
        context,
        '/error-qr',
        arguments: {"code": result!.code.toString()},
      );
    }

    void onQRViewCreated(QRViewController controller) async {
      this.controller = controller;
      await controller.flipCamera();

      controller.scannedDataStream.listen((scanData) async {
        authenticado = true;
        result = scanData;
        if (result != null) {
          controller.disposed = true;
          if (result != null) {
            controller.stopCamera();
            log('codigo detectado  ${result!.code.toString()}');
            await verifiedCodeProvider.verifiedCode(result!.code.toString());
            if (verifiedCodeProvider.isValid) {
              log('codigo correcto  ${verifiedCodeProvider.isValid.toString()}');
              navigateConfirmate(verifiedCodeProvider.movement);
            } else {
              log(
                'codigo incorrecta  ${verifiedCodeProvider.isValid.toString()}',
              );
              navigateRetry();
            }
          }
        }
        setState(() {});
      });
    }

    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        verifiedCodeProvider.detectCodeQr(event.character.toString());
        if (verifiedCodeProvider.isValid) {
          //navigateConfirmate(verifiedCodeProvider.movement);
        }
        print('High-priority ESC pressed. ${event.character}');
        return KeyEventResult.handled;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            'QR ${verifiedCodeProvider.codeQR}',
            style: TextStyle(color: ConfigColor.appBarTextColor),
          ),
        ),
        body: Column(
          children: <Widget>[
             Expanded(
              flex: 6,
              child: QRView(key: qrKey, onQRViewCreated: onQRViewCreated),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child:
                    (result != null)
                        ? Text(
                          'Barcode Type:  ${result!.format.toString()}  Data: ${result!.code} isValidate: ${authenticado.toString()}',
                        )
                        : Text(
                          'Escaneando... ${verifiedCodeProvider.codeQR}',
                          style: TextStyle(color: ConfigColor.appBarTextColor),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verifiedCodeProvider = context.watch<VerifiedCodeProvider>();

    void navigateConfirmate(VerifiedCodeModel verifiedcode) {
      Navigator.pushNamed(
        context,
        '/confirm-reception',
        arguments: verifiedcode,
      );
    }

    void navigateRetry(VerifiedCodeModel verifiedcode) {
      Navigator.pushNamed(context, '/error-qr', arguments: verifiedcode);
    }

    Future<void> verificateCode(KeyEvent event) async {
      await verifiedCodeProvider.detectCodeQr(event.character.toString());
      if (verifiedCodeProvider.isValid) {
        verifiedCodeProvider.codeQR = '';
        navigateConfirmate(verifiedCodeProvider.movement);
      } else {
        verifiedCodeProvider.codeQR = '';
        navigateRetry(verifiedCodeProvider.movement);
      }
    }

    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        verificateCode(event).then((value) {});
        //print('High-priority ESC pressed. ${event.character}');
        return KeyEventResult.handled;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            'QR ${verifiedCodeProvider.codeQR}',
            style: TextStyle(color: ConfigColor.appBarTextColor),
          ),
        ),
        body: Column(
          children: <Widget>[
            /*  Expanded(
              flex: 6,
              child: QRView(key: qrKey, onQRViewCreated: onQRViewCreated),
            ), */
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Escaneando... ${verifiedCodeProvider.codeQR}',
                  style: TextStyle(color: ConfigColor.appBarTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
