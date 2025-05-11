import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:provider/provider.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<ReceptionProvider>();
    final lockerProvider = context.watch<ReceptionProvider>();

    userProvider.getListUsers();
    lockerProvider.getListLockers();
    final users = userProvider.userList;
    final lockers = lockerProvider.lockerList;

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
                              value: locker.id,
                              child: Text(
                                'Casillero ${locker.id.toString()}',
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
                              //Aqui nos debe abrir el casillero y cuando
                              //detecte que el casillero cerró una ventana flotante
                              //GRACIAS con boton OK para que envíe la alerta
                              //al cliente y vuelve al estado inicial la app
                            },
                        child: Text('Entregar'),
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
