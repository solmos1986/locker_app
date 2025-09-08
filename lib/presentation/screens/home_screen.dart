import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/screens/client_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final data = ConectionSerial();
    /*     final test2 = ConectionSerialTest2();
    final test3 = Test3(); */
    return Transform.rotate(
      angle: pi / 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/config');
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          title: Text(
            'SMART LOCKER',
            style: TextStyle(color: ConfigColor.appBarTextColor),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 150,
                      child: Image.network(
                        'https://holdinghome.com.bo/web-publica/img/logo-hh.png',
                        fit: BoxFit.contain,
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  // 70%
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async {
                          //await data.getPorts();
                          //data.inizialize();
                          DateTime now = DateTime.now();
                          //test2.inizialize();
                          //await data.getPorts();
                          //await data.setMessage();
                          String formattedDate = DateFormat(
                            'MMMM dd, yyyy Hms',
                          ).format(now);

                          log(formattedDate);
                          Navigator.pushNamed(context, '/reception');
                        },
                        child: Text('Entregar'),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      top: 5,
                    ),
                    child: SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientScreen(),
                                ),
                              ),
                            },
                        child: Text('Recoger'),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
