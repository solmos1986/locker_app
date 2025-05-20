import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';

class ConfirmDeliveryScreen extends StatelessWidget {
  const ConfirmDeliveryScreen({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Confirmar Información',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 250,
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
                    left: 30,
                    right: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'Cliente: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Departamento 1',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Casillero: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'No. 1',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            'Tamaño: ',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pequeño',
                            style: TextStyle(
                              color: Colors.white,
                              height: 2,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 40, right: 5),
            ),
            SizedBox(
              width: 100,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(115, 0, 0, 0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/images/cheque.png'),
                    ),
                    SizedBox(height: 40),
                    //Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/images/eliminar.png'),
                    ),
                  ],
                ),
                //color: const Color.fromARGB(160, 255, 255, 255),
              ),
            ),
          ],
        ),
        /* child: Column(
          children: <Widget>[
            Expanded(
              flex: 1, // 70%
              child: Text('Flex 1'),
            ),
            Expanded(
              flex: 3, // 70%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cliente: Departamento 1',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Casillero No. 1',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Tamaño PEQUEÑO',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Text('Flex 3')),
          ],
        ), */
      ),
    );
  }
}

pingeneretor() {
  DateTime fechaActual = DateTime.now();
  //final fechafinal = DateTime(2195 - 01 - 01); //utilice esta fecha para ver si varian la cantidad de digitos, no varian podemos usar hasta el año 2195
  final multi = 100000; //variable para siempre tener 6 digitos
  final depar = 301; //este dato lo obtendremos de la tabla users
  final hora = fechaActual.hour;
  final min = fechaActual.minute;
  final seg = fechaActual.second;
  final passcom = depar + hora + min + seg + multi;
  print('passcomm:  $passcom');
  final formatter = DateTime(
    1990 - 01 - 01,
  ); //fecha referencia para encontrar la diferencia ///STIVEEEN este valor es fijo no cambiaaa....
  //final formattedDate = formatter.format(dateTime);
  Duration miliactual = fechaActual.difference(formatter);
  var diference = miliactual.inDays + passcom;
  print('diferencia en dias: ${miliactual.inDays}');
  print('pass final: $diference');
}
