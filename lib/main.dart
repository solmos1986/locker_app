import 'package:flutter/material.dart';
import 'package:locker_app/pages/depas.dart';
import 'package:locker_app/presentation/client/qr_screen.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Mi App2", home: Inicio());
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          //shrinkWrap: true,
          //padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Expanded(
              flex: 3, // 30%
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(0.0)),
                  Image.network(
                    'https://holdinghome.com.bo/web-publica/img/logo-hh.png',
                    fit: BoxFit.contain,

                    height: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3, // 70%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(20.0)),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Depas()),
                            ),
                          },
                      child: Text('Entregar'),
                    ),
                  ),
                  //SizedBox(height: 30),
                ],
              ),
            ),
            Expanded(
              flex: 3, // 70%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(20.0)),
                  // SizedBox(height: 30),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  QrScreen()),
                            ),
                          },
                      child: Text('Recoger'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2, // 70%
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
