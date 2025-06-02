import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';

import 'package:locker_app/presentation/screens/password_screen.dart';
import 'package:locker_app/presentation/screens/qr_screen.dart';
class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Metodos de autenticación',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5, // 70%
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
                      right: 20,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(115, 77, 76, 76),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: const Color.fromARGB(160, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 110,
                                  child: Image.asset('assets/images/qr.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0,
                                    bottom: 15,
                                    left: 10,
                                    right: 5,
                                  ),
                                ),
                                Text(
                                  'Escanear QR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                /* Text(
                                  'medidas: 15x10x50',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QrScreen()),
                        );
                        print("tapped on container");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 25,
                      right: 5,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(115, 77, 76, 76),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //color: const Color.fromARGB(160, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              left: 1,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,
                                  child: Image.asset(
                                    'assets/images/contrasena1.png',
                                  ),
                                ),
                                //Image.asset('assets/images/caja.png'),
                                Text(
                                  'Ingresar CODIGO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                /* Text(
                                  'medidas: 15x10x50',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Password()),
                        );
                        print("tapped on container");
                      },
                    ),
                    //print("tapped on container");
                  ),
                  //),
                  //),
                  //SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ) /* */,
    );
  }
}
