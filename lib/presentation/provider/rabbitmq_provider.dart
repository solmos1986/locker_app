import 'dart:async';
import 'dart:developer';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/infrastructure/models/open_door.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/utils/get_log_reponse.dart';

class UtilRabbtiMqProvider {
  final connectSerial = ConnectSerial();
  final getLogReponse = GetLogReponse();
  final requestComandRepository = RequestComandRepository();

  Client client = Client(
    settings: ConnectionSettings(
      host: "109.199.126.105",
      port: 32772,
      authProvider: PlainAuthenticator("admin", "rabbit.2025"),
      virtualHost: "/",
    ),
  );

  Future<void> connecRabbit() async {
    log('RabbtiMqProvider connecRabbit');
    try {
      Channel channel = await client.channel();
      Queue queue = await channel.queue("open");
      Consumer consumer = await queue.consume();
      consumer.listen((AmqpMessage message) async {
        log(" [x] Received payloadAsString: ${message.payloadAsString}");
        log(" [x] Received payloadAsJson: ${message.payloadAsJson}");
        //message.ack();

        //message.reply("ok");

        final openDoor = OpenDoorModel.fromJson(message.payloadAsJson);
        log(" abrir puerta : ${openDoor.doorId}");

        final comands = await requestComandRepository.getCodeForDoor(
          openDoor.doorId,
          "abrir",
        );

        connectSerial.getListenSerial().listen((SerialResponse? result) async {
          final value = getLogReponse.getLogsResponse(result!.readChannel!);
          if (value == comands.first.responseComand) {
            log(" codigo enviado para abrir");
          }
        });

        connectSerial.sendMessage(comands.first.requestComand);
      });
    } catch (e) {
      log(" [x] error string: ${e.toString()}");
    }
  }
}
