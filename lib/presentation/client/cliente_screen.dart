import 'package:flutter/material.dart';
import 'package:locker_app/presentation/client/password_screen.dart';
import 'package:locker_app/presentation/client/qr_screen.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Autenticación'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrScreen(),
                        ),
                      ),
                    },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(Icons.qr_code, size: 45),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Escanea tu QR',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* TextButton(onPressed: () {}, child: Text('Text Button')),
            OutlinedButton(onPressed: () {}, child: Text('Outlined Button')),
            CupertinoButton(child: Text('Cupertino Button'), onPressed: () {}), */
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmateScreen(),
                        ),
                      ),
                    },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(Icons.key, size: 45),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Ingresa tu contraseña',
                        style: TextStyle(fontSize: 20),
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
