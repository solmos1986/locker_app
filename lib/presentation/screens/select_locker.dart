import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/services.dart' show rootBundle;

class SelectLockerScreen extends StatelessWidget {
  const SelectLockerScreen({super.key, required this.password});
  
  final String password;
  /*  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/caja.png');
  } */

  @override
  Widget build(BuildContext context) {
    final receptionProvider = context.watch<ReceptionProvider>();

    receptionProvider.getListAvailableDoors();

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Selecciona un casillero ${password.toString()}',
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
                      right: 5,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 150,
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
                                  height: 80,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                Text(
                                  receptionProvider.doorSmall.name,
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
                                Text(
                                  'disponibles : ${receptionProvider.doorSmall.total}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/confirm-delivery');
                        print("tapped on container");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
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
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 110,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                Text(
                                  receptionProvider.doorMedium.name,
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
                                Text(
                                  'disponibles: ${receptionProvider.doorMedium.total}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/confirm-delivery');
                        print("tapped on container");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                      left: 10,
                      right: 5,
                    ),
                    child: InkWell(
                      child: SizedBox(
                        width: 200,
                        height: 270,
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
                              children: <Widget>[
                                SizedBox(
                                  height: 170,
                                  child: Image.asset('assets/images/caja.png'),
                                ),
                                //Image.asset('assets/images/caja.png'),
                                Text(
                                  receptionProvider.doorBig.name,
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
                                Text(
                                  'disponibles: ${receptionProvider.doorBig.total.toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/confirm-delivery');
                        print("tapped on container");
                      },
                    ),
                  ),
                  //SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
