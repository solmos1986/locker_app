import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:locker_app/presentation/screens/select_locker.dart';
import 'package:provider/provider.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<ReceptionProvider>();
    final receptionProvider = context.watch<ReceptionProvider>();

    userProvider.getListUsers();
    receptionProvider.getListAvailableDoors();

    final users = userProvider.userList;
    //print('users: ${users.toString()}');

    List<Widget> widgets =
        users
            .map(
              (user) => Text(
                'Departamento ${user.name}',
                style: TextStyle(color: Colors.white),
              ),
            )
            .toList();

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
              Navigator.pushNamed(
                context,
                '/select-locker',
                arguments: {'password': 'parametro extra'},
              );
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
