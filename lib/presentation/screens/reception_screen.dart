import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/presentation/provider/reception_provider.dart';
import 'package:provider/provider.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receptionProvider = context.watch<ReceptionProvider>();

    receptionProvider.getListUsers();
    //receptionProvider.getListAvailableDoors();

    final users = receptionProvider.userList;
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
              /* Parametro de entrada */
              Navigator.pushNamed(
                context,
                '/select-locker',
                arguments: MovementModel(
                  doorId: 0,
                  userId: users[index].userId,
                  nameUser: users[index].name,
                  numberDoor: 0,
                  nameSizeDoor: '',
                  code: '',
                ),
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
