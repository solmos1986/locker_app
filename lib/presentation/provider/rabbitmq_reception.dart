import 'dart:async';
import 'dart:developer';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/foundation.dart';

class RabbtiMqProvider extends ChangeNotifier {
  Future<void> openDoor() async {
    log('RabbtiMqProvider openDoor');

    ConnectionSettings settings = ConnectionSettings(
      host: "109.199.126.105",
      port: 32772,
      authProvider: PlainAuthenticator("admin", "rabbit.2025"),
      virtualHost: "/",
    );
    Client client = Client(settings: settings);
    try {
      Channel channel =
          await client
              .channel(); // auto-1connect to localhost:5672 using guest credentials
      Queue queue = await channel.queue("hello");
      Consumer consumer = await queue.consume();
      consumer.listen((AmqpMessage message) {
        // Get the payload as a string
        log(" [x] Received string: ${message.payloadAsString}");
        message.ack();
        /*  // Or unserialize to json
      log(" [x] Received json: ${message.payloadAsJson}");

      // Or just get the raw data as a Uint8List
      log(" [x] Received raw: ${message.payload}");
 */
        // The message object contains helper methods for
        // replying, ack-ing and rejecting
        message.reply("ok");
        notifyListeners();
        consumer.cancel();
      });
    } catch (e) {
      log(" [x] error string: ${e.toString()}");
    }
  }
}
