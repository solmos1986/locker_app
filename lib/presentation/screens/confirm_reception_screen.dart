import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/presentation/provider/confirm_reception_provider.dart';
import 'package:locker_app/widgets/reception/modal_content.dart';
import 'package:provider/provider.dart';

class ConfirmReceptionScreen extends StatelessWidget {
  const ConfirmReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movementProvider = context.watch<ConfirmReceptionProvider>();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as VerifiedCodeModel;

    /* void closedModal() {
      Navigator.pop(context);
    } */

    Future<void> activateButtonNavigate() async {
      await movementProvider.confirmeReception(arguments);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    void openModal(VerifiedCodeModel verified) {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => ModalContent(
              message: "¿Abrio la puerta?",
              onPressOk: (state) async {
                await activateButtonNavigate();
              },
              nameButonOk: 'Si',
              onPressCancel: (state) async {
                await movementProvider.retry(verified);
                if (movementProvider.isValid) {
                  openModal(verified);
                }
              },
              nameButonCancel: 'No',
            ),
      );
    }

    Future<void> verifiedMovement() async {
      await movementProvider.updateMovement(arguments);
      if (movementProvider.isValid) {
        log('confimando que si recibio');
      } else {
        log('casillero no abierto');
        openModal(arguments);
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Casillero abierto',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(115, 77, 76, 76),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 10),
                      child: Text(
                        movementProvider.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Casillero: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '#${arguments.numberDoor}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Tamaño de casillero: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            arguments.nameSizeDoor,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await verifiedMovement();
                //await movementProvider.updateMovement(arguments.movementId);
              },
              child: Text('Abrir casillero'),
            ),
          ),
        ],
      ),
    );
  }
}
