import 'package:flutter/material.dart';
import 'package:locker_app/presentation/client/close_locker.dart';
import 'package:locker_app/widgets/client/password_field_box.dart';

class ConfirmateScreen extends StatefulWidget {
  const ConfirmateScreen({super.key});

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Por favor escribe tu contraseña',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            PasswordFieldBox(
              onSubmitted:
                  (password) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CloseLocker(password: password),
                      ),
                    ),
                  },
            ),
          ],
        ),
      ),
    );
  }
}
