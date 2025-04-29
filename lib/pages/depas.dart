import 'package:flutter/material.dart';
import 'package:locker_app/main.dart';

//void main() => runApp(MiApp());

class Depas extends StatelessWidget {
  const Depas({super.key});

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
    List listDepa = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
    ];
    List listLocks = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          //shrinkWrap: true,
          //padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Expanded(
              flex: 2, // 30%
              child: Container(
                color: Colors.black,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.all(0)),
                    Image.network(
                      'https://holdinghome.com.bo/web-publica/img/logo-hh.png',
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2, // 30%
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Text(
                      'Selecciona un departamento',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    width: 300,
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.white.withOpacity(0.8),
                      items:
                          listDepa.map((name) {
                            return DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2, // 30%.
              //child: Container(
              //color: Colors.white.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Container(
                    color: Colors.black.withOpacity(0.3),

                    child: Text(
                      'Selecciona un casillero',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    width: 300,
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.white.withOpacity(0.8),
                      items:
                          listLocks.map((name) {
                            return DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1, // 10%
              child: Container(
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed:
                            () => {
                              //Aqui nos debe abrir el casillero y cuando
                              //detecte que el casillero cerró una ventana flotante
                              //GRACIAS con boton OK para que envíe la alerta
                              //al cliente y vuelve al estado inicial la app
                            },
                        child: Text('Entregar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1, // 10%
              child: Container(
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 400,
                      child: IconButton(
                        icon: Icon(Icons.chevron_left),
                        iconSize: 35,
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MiApp()),
                          );
                        },
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
