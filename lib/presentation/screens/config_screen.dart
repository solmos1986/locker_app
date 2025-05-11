import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();

    Future<void> onPressUpdateDataBase() async {
      await configProvider.getDataBase();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Configuracion',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => {onPressUpdateDataBase()},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        configProvider.load ? 'Cargando...' : 'Actualizar database',
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
