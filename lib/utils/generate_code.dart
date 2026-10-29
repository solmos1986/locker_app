import 'dart:math';

import 'package:locker_app/config/database.dart';

class GenerateCode {
  final _random = Random.secure();

  /// Código aleatorio de 6 dígitos que no esté en uso por una entrega
  /// pendiente (tipo 1 sin su retiro tipo 2) en la BD local.
  Future<String> generateCode() async {
    final db = await LockeAppDatabase.instance.database;
    while (true) {
      final code = (100000 + _random.nextInt(900000)).toString();
      final enUso = await db.rawQuery(
        "SELECT 1 FROM movement WHERE code = ? and type_movement_id = 1 "
        "and NOT EXISTS (SELECT 1 FROM movement m2 WHERE m2.id_ref = movement.id_ref and m2.code = movement.code and m2.door_id = movement.door_id and m2.type_movement_id = 2) LIMIT 1",
        [code],
      );
      if (enUso.isEmpty) return code;
    }
  }
}
