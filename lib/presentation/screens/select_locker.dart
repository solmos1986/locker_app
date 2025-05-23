import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/helper/door_available.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/presentation/provider/select_locker_provider.dart';
import 'package:locker_app/widgets/reception/modal_content.dart';
import 'package:provider/provider.dart';

class SelectLockerScreen extends StatelessWidget {
  const SelectLockerScreen({super.key, this.movement});

  final MovementModel? movement;

  /*  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/caja.png');
  } */

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as MovementModel;

    final selectLockerProvider = context.watch<SelectLockerProvider>();

    selectLockerProvider.getListAvailableDoors();

    void activateButton(bool valid, DoorAvailable door) {
      if (valid) {
        Navigator.pushNamed(
          context,
          '/confirm-delivery',
          arguments: MovementModel(
            doorId: door.doorId,
            code: '',
            nameSizeDoor: door.name,
            nameUser: arguments.nameUser,
            numberDoor: door.number,
            userId: arguments.userId,
          ),
        );
      }
    }

    void verifieDoor(DoorAvailable door) {
      door.total > 0
          ? (showDialog<String>(
            context: context,
            builder:
                (BuildContext context) => ModalContent(
                  onPress: (state) => {activateButton(state, door)},
                  message:
                      "¿Esta abierto el casillero numero # ${door.number}?",
                ),
          ))
          : null;
    }

    Future<void> openDoor(DoorAvailable door) async {
      if (door.total > 0) {
        await selectLockerProvider.openDoor(
          door,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Selecciona un casillero ${arguments.nameUser.toString()}',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5, // 70%
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
                      right: 5,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(115, 77, 76, 76),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: const Color.fromARGB(160, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                Text(
                                  selectLockerProvider.doorSmall.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /* Text(
                                  'medidas: 15x10x50',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ), */
                                Text(
                                  'disponibles : ${selectLockerProvider.doorSmall.total}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap:
                          () async => {
                            await openDoor(
                              selectLockerProvider.doorSmall,
                            ),
                            verifieDoor(selectLockerProvider.doorSmall),
                          },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
                      right: 5,
                    ),
                    child: InkWell(
                      onTap:
                          () async => {
                            await openDoor(
                              selectLockerProvider.doorMedium,
                            ),
                            verifieDoor(selectLockerProvider.doorMedium),
                          },
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(115, 77, 76, 76),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: const Color.fromARGB(160, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 110,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                Text(
                                  selectLockerProvider.doorMedium.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /* Text(
                                  'medidas: 15x10x50',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ), */
                                Text(
                                  'disponibles: ${selectLockerProvider.doorMedium.total}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
                      right: 5,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 270,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(115, 77, 76, 76),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: const Color.fromARGB(160, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 170,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                //Image.asset('assets/images/caja.png'),
                                Text(
                                  selectLockerProvider.doorBig.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /* Text(
                                  'medidas: 15x10x50',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ), */
                                Text(
                                  'disponibles: ${selectLockerProvider.doorBig.total.toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap:
                          () async => {
                            await openDoor(
                              selectLockerProvider.doorBig,
                            ),
                            verifieDoor(selectLockerProvider.doorBig),
                          },
                    ),
                  ),
                  //SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
