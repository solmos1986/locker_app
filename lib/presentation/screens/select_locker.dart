import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/helper/door_available.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/presentation/provider/select_locker_provider.dart';
import 'package:locker_app/widgets/reception/modal_content.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

    //selectLockerProvider.getListAvailableDoors();

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
        await selectLockerProvider.openDoor(door);
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Tamaño del casillero',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: ResponsiveBuilder(
        builder:
            (context, sizingInformation) => Center(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap:
                              () async => {
                                await openDoor(selectLockerProvider.doorSmall),
                                verifieDoor(selectLockerProvider.doorSmall),
                              },
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
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(80),
                                    child: Image.asset(
                                      'assets/images/caja.png',
                                    ),
                                  ),
                                  Text(
                                    selectLockerProvider.doorSmall.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'Disponibles : ${selectLockerProvider.doorSmall.total}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap:
                              () async => {
                                await openDoor(selectLockerProvider.doorMedium),
                                verifieDoor(selectLockerProvider.doorMedium),
                              },
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
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(40),
                                    child: Image.asset(
                                      'assets/images/caja.png',
                                    ),
                                  ),
                                  Text(
                                    selectLockerProvider.doorMedium.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'disponibles: ${selectLockerProvider.doorMedium.total}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap:
                              () async => {
                                await openDoor(selectLockerProvider.doorBig),
                                verifieDoor(selectLockerProvider.doorBig),
                              },
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
                                children: [
                                  Image.asset('assets/images/caja.png'),
                                  Text(
                                    selectLockerProvider.doorBig.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'Disponibles: ${selectLockerProvider.doorBig.total.toString()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
