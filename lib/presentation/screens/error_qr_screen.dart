import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';

class ErrorQrScreen extends StatelessWidget {
  const ErrorQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as VerifiedCodeModel;

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'QR no valido',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'QR NO VALIDO',
                  style: TextStyle(color: ConfigColor.appBarTextColor),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Reintentar'),
                onPressed:
                    () => {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      ),
                    },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
