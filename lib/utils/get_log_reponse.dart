import 'dart:developer';

class GetLogReponse {
  String getLogsResponse(String? logs) {
    final valores =
        logs!
            //.replaceAll("\n", "-")
            .split("\n")
            .map((String text) => text)
            .toList();

    /*  for (var val in logs) {
      log("ConnectSerial escuchando.. $val");
    } */

    if (valores.length > 1) {
      final value = valores[valores.length - 2];

      final nuevo = value.replaceAll("/dev/ttyS0/hex read：", "");
      //log("ultimo valor $nuevo");
      return nuevo;
    } else {
      return "";
    }
  }
}
