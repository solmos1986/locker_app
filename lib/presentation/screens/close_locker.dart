import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';

class CloseLockerScreen extends StatelessWidget {
  const CloseLockerScreen({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Casillero abierto',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'No olvide cerrar el casillero ${password.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                    color: ConfigColor.appBarTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
