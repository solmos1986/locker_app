import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:locker_app/presentation/provider/confirm_reception_provider.dart';
import 'package:locker_app/presentation/provider/movement_provider.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:locker_app/presentation/provider/select_locker_provider.dart';
import 'package:locker_app/presentation/provider/verified_code_provider.dart';
import 'package:locker_app/presentation/screens/client_screen.dart';
import 'package:locker_app/presentation/screens/confirm_delivery_screen.dart';
import 'package:locker_app/presentation/screens/confirm_reception_screen.dart';
import 'package:locker_app/presentation/screens/error_qr_screen.dart';
import 'package:locker_app/presentation/screens/select_locker.dart';
import 'package:locker_app/presentation/screens/config_screen.dart';
import 'package:locker_app/presentation/screens/home_screen.dart';
import 'package:locker_app/presentation/screens/password_screen.dart';
import 'package:locker_app/presentation/screens/qr_screen.dart';
import 'package:locker_app/presentation/screens/reception_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force Portrait Mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, // Normal Portrait
    //DeviceOrientation.landscapeRight, // Upside-Down Portrait
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => MovementProvider()),
        ChangeNotifierProvider(create: (_) => VerifiedCodeProvider()),
      ],
      child: MaterialApp(
        title: 'Lock App',
        theme: AppTheme().theme(),
        initialRoute: '/home',
        routes: {
          "/home": (context) => HomeScreen(),
          "/client": (context) => ClientScreen(),
          "/reception":
              (context) => ChangeNotifierProvider(
                create: (context) => ReceptionProvider(),
                builder: (context, child) => const ReceptionScreen(),
              ),
          "/select-locker":
              (context) => ChangeNotifierProvider(
                create: (context) => SelectLockerProvider(),
                builder: (context, child) => const SelectLockerScreen(),
              ),
          "/password": (context) => ChangeNotifierProvider(
                create: (context) => VerifiedCodeProvider(),
                builder: (context, child) => Password(),
              ),
          "/qr-scan": (context) => ChangeNotifierProvider(
                create: (context) => VerifiedCodeProvider(),
                builder: (context, child) =>const QrScreen(),
              ),
          "/config": (context) => ConfigScreen(),
          "/confirm-delivery": (context) => ConfirmDeliveryScreen(),
          "/confirm-reception":
              (context) => ChangeNotifierProvider(
                create: (context) => ConfirmReceptionProvider(),
                builder: (context, child) => const ConfirmReceptionScreen(),
              ),
          "/error-qr": (context) => ErrorQrScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
