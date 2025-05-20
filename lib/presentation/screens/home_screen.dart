import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:locker_app/presentation/screens/client_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();
    configProvider.inizializeDataBase();

    return Scaffold(
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
                  Padding(padding: EdgeInsets.all(15.0)),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed:
                          () => {Navigator.pushNamed(context, '/reception')},
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
                  Padding(padding: EdgeInsets.all(15.0)),
                  // SizedBox(height: 30),
                  SizedBox(
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
