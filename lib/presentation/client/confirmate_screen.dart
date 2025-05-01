import 'package:flutter/material.dart';

class ConfirmateScreen extends StatefulWidget {
  const ConfirmateScreen({
    super.key,
    required String user,
  });

  @override
  State<ConfirmateScreen> createState() => _ConfirmateScreenState();
}

class _ConfirmateScreenState extends State<ConfirmateScreen> {
  final String user = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Confirma que eres tu'),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(
            child: Text('usuario ${user.toString() }',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Introduce tu Contraseña',
              ),
            ),
          ),
        )
      ]),
    );
  }
}
