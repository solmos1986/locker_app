import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:background_task/background_task.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/config_provider.dart';
import 'package:locker_app/presentation/provider/confirm_reception_provider.dart';
import 'package:locker_app/presentation/provider/movement_provider.dart';
import 'package:locker_app/presentation/provider/rabbitmq_provider.dart';
import 'package:locker_app/presentation/provider/rabbitmq_reception.dart';
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
import 'package:workmanager/workmanager.dart';

// Define callback handler at the top level.
/* @pragma('vm:entry-point')
void backgroundHandler(Location data) {
  log('backgroundHandler');
  debugPrint('backgroundHandler: ${DateTime.now()}, $data');
  Timer.periodic(Duration(seconds: 5), (timer) {
    print("Background task running: ${DateTime.now()}");
    log("Background task running: ${DateTime.now()}");
  });
} */

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background task: $task");
    log("Background task: $task");
    /* UtilRabbtiMqProvider rabbtiMqProvider = UtilRabbtiMqProvider();
    await rabbtiMqProvider.openDoor(); */
    // Your background work here
    return Future.value(true);
  });
}

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  //await BackgroundTask.instance.setBackgroundHandler(backgroundHandler);
  BackgroundTask.instance.setBackgroundHandler(backgroundHandler); */
  WidgetsFlutterBinding.ensureInitialized();
  /* Workmanager().initialize(callbackDispatcher);
  Workmanager().registerOneOffTask(
    "task-id-1",
    "tarea_rabbit",
    initialDelay: const Duration(seconds: 2),
    constraints: Constraints(
      networkType:
          NetworkType
              .connected, // Example constraint: requires network connection
    ),
  ); */

  // Stop background processing and location updates.
  //await BackgroundTask.instance.stop();

  UtilRabbtiMqProvider rabbtiMqProvider = UtilRabbtiMqProvider();
  await rabbtiMqProvider.connecRabbit();

  log("DateTime : ${DateTime.now().toString()}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RabbtiMqProvider()),
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => MovementProvider()),
        ChangeNotifierProvider(create: (_) => VerifiedCodeProvider()),
      ],
      child: Transform.rotate(
        angle: math.pi / 2,
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
            "/password":
                (context) => ChangeNotifierProvider(
                  create: (context) => VerifiedCodeProvider(),
                  builder: (context, child) => Password(),
                ),
            "/qr-scan":
                (context) => ChangeNotifierProvider(
                  create: (context) => VerifiedCodeProvider(),
                  builder: (context, child) => const QrScreen(),
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
      ),
    );
  }
}
