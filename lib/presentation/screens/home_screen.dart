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
                      onPressed:
                          () => {Navigator.pushNamed(context, '/reception')},
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
    );
  }
}
