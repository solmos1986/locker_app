import 'package:flutter/material.dart';

class CloseLocker extends StatelessWidget {
  const CloseLocker({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Casillero abierto'),
        centerTitle: true,
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
