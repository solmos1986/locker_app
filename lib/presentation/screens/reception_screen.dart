import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/user_model.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:locker_app/presentation/screens/client_screen.dart';
import 'package:locker_app/presentation/screens/select_locker.dart';
import 'package:locker_app/repositories/users_migration.dart';
import 'package:provider/provider.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<ReceptionProvider>();
    final lockerProvider = context.watch<ReceptionProvider>();

    userProvider.getListUsers();
    lockerProvider.getListLockers();
    final users = userProvider.userList;
    //print('users: ${users.toString()}');
    final lockers = lockerProvider.lockerList;
    List<Widget> widgets =
        users
            .map(
              (user) => Text(
                'Departamento ${user.name}',
                style: TextStyle(color: Colors.white),
              ),
            )
            .toList();
    void open() {}

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Selecciona un departamento',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: users.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/select-locker');
              print("tapped on container");
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(115, 77, 76, 76),
                  borderRadius: BorderRadius.circular(12),
                ),

                //color: const Color.fromARGB(115, 77, 76, 76),
                child: Center(child: widgets[index]),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, index) => const Divider(),
      ),
    );
  }
}
