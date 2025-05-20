import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:locker_app/presentation/provider/movement_provider.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:locker_app/presentation/screens/client_screen.dart';
import 'package:locker_app/presentation/screens/confirm_delivery_screen.dart';
import 'package:locker_app/presentation/screens/select_locker.dart';
import 'package:locker_app/presentation/screens/config_screen.dart';
import 'package:locker_app/presentation/screens/home_screen.dart';
import 'package:locker_app/presentation/screens/password_screen.dart';
import 'package:locker_app/presentation/screens/qr_screen.dart';
import 'package:locker_app/presentation/screens/reception_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => ReceptionProvider()),
        ChangeNotifierProvider(create: (_) => MovementProvider()),
      ],
      child: MaterialApp(
        title: 'Lock App',
        theme: AppTheme().theme(),
        initialRoute: '/home',
        routes: {
          "/home": (context) => HomeScreen(),
          "/client": (context) => ClientScreen(),
          "/reception": (context) => ReceptionScreen(),
          "/select-locker": (context) => SelectLockerScreen(password: ''),
          "/password": (context) => Password(),
          "/qr-scan": (context) => QrScreen(),
          "/config": (context) => ConfigScreen(),
          "/confirm-delivery": (context) => ConfirmDeliveryScreen(password: ''),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
