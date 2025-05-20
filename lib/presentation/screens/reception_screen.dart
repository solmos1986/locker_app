import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/movement_provider.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:provider/provider.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<ReceptionProvider>();
    final lockerProvider = context.watch<ReceptionProvider>();
    final movementProvider = context.watch<MovementProvider>();

    userProvider.getListUsers();
    lockerProvider.getListDoors();

    final users = userProvider.userList;
    final lockers = lockerProvider.doorList;

    void open() {}

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Deja tu encomienda',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Column(
          //shrinkWrap: true,
          //padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Expanded(
              flex: 2, // 30%
              child: Container(
                color: Colors.black,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.all(0)),
                    Image.network(
                      'https://holdinghome.com.bo/web-publica/img/logo-hh.png',
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2, // 30%
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: Text(
                      'Selecciona un departamento',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 300,
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.white.withValues(alpha: 0.8),
                      items:
                          users.map((user) {
                            return DropdownMenuItem(
                              value: user.name,
                              child: Text(
                                'Depart #${user.name}',
                                style: TextStyle(),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2, // 30%.
              //child: Container(
              //color: Colors.white.withValues(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: Text(
                      'Selecciona un casillero',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 300,
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.white.withValues(alpha: 0.8),
                      items:
                          lockers.map((locker) {
                            return DropdownMenuItem(
                              value: locker.doorId,
                              child: Text(
                                'Casillero ${locker.number.toString()}',
                                style: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.6),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1, // 10%
              child: Container(
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed:
                            () => {
                              print('485 ok'),
                              showDialog<String>(
                                context: context,
                                builder:
                                    (BuildContext context) => Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Text('Abrio la puerta?'),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                  onPressed: () async  {
                                                    await movementProvider.sendMovement(5);
                                                    //Navigator.pushNamed(context, '/close-locker');
                                                  },
                                                  child: const Text('si'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ),
                            },
                        child: Text('Abrir casillero'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
