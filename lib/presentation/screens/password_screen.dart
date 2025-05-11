import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:locker_app/presentation/screens/close_locker.dart';
import 'package:locker_app/widgets/client/password_field_box.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  final String user = '';

  @override
  Widget build(BuildContext context) {
    final movementProvider = context.watch<ReceptionProvider>();

    Future<bool> onSendPassword(String password) async {
      if (password == '12345') {
        await movementProvider.sendMovement('test');
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: ConfigColor.iconThemeData,
        actions: [],
        title: Text(
          'Escribe tu contraseña',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: ConfigColor.appBarBackground,
      ),
      backgroundColor: ConfigColor.background,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Por favor escribe tu contraseña, los movimientos son ${movementProvider.userList.length.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                    color: ConfigColor.appBarTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            PasswordFieldBox(
              onSubmitted:
                  (password) => {
                    onSendPassword(password),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CloseLockerScreen(password: password),
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
