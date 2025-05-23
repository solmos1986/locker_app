import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/presentation/provider/movement_provider.dart';
import 'package:locker_app/widgets/reception/modal_content.dart';
import 'package:provider/provider.dart';

class ConfirmDeliveryScreen extends StatelessWidget {
  const ConfirmDeliveryScreen({super.key, required});

  @override
  Widget build(BuildContext context) {
    final movementProvider = context.watch<MovementProvider>();

    final arguments =
        ModalRoute.of(context)?.settings.arguments as MovementModel;

    void sendMovement(bool state) {
      if (state) {
        movementProvider.sendMovement(arguments);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    }

    void verifiedMovement() {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => ModalContent(
              onPress: (state) => sendMovement(state),
              message: "¿Indrodusca y cierre la puerta?",
            ),
      );
    }

    Future<void> verifiedDoor() async {
      await movementProvider.verifiedCloseDoor(arguments);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Confirmar Información',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 250,
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
                    left: 30,
                    right: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'Cliente: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            arguments.nameUser,
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Casillero: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            arguments.numberDoor.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            'Tamaño: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            arguments.nameSizeDoor.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 40, right: 5),
            ),

            /*  ElevatedButton(
  onPressed: () {},
  child: Text('Elevated Button'),
),
TextButton(
  onPressed: () {},
  child: Text('Text Button'),
), OutlinedButton(
  onPressed: () {},
  child: Text('Outlined Button'),
),*/
            /* AbsorbPointer(
              absorbing: true,
              child: ElevatedButton(onPressed: () {}, child: Text('Button')),
            ), */
            SizedBox(
              width: 100,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(115, 0, 0, 0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: SizedBox(
                        height: 80,
                        child: Image.asset('assets/images/cheque.png'),
                      ),
                      onPressed: () async {
                        await verifiedDoor();
                        verifiedMovement();
                      },
                    ),

                    /* SizedBox(height: 40), */
                    //Expanded(child: SizedBox.shrink())
                    CupertinoButton(
                      child: SizedBox(
                        height: 80,
                        child: Image.asset('assets/images/eliminar.png'),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                    ),
                  ],
                ),
                //color: const Color.fromARGB(160, 255, 255, 255),
              ),
            ),
          ],
        ),
        /* child: Column(
          children: <Widget>[
            Expanded(
              flex: 1, // 70%
              child: Text('Flex 1'),
            ),
            Expanded(
              flex: 3, // 70%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cliente: Departamento 1',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Casillero No. 1',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Tamaño PEQUEÑO',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Text('Flex 3')),
          ],
        ), */
      ),
    );
  }
}
