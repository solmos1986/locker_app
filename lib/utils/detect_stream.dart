import 'dart:developer';

import 'package:flutter_serial/flutter_serial.dart';

class DetectStream {
  Future<String> detectStreamLog(
    Stream<SerialResponse> stream,
    String verificar,
  ) async {
    var result = '';
    try {
      await for (final value in stream) {
        log('valor $value comparar $verificar');
        if (verificar == value.toString()) {
          result = value.toString();
          throw Exception('Intentional exception');
        }
      }
    } catch (e) {
      log('error $e');
      return result;
    }
    return result;
  }

  Future<R> callWithMinimumDuration<R>(
    Future<R> Function() func,
    Duration minimumDuration,
  ) async {
    var stopwatch = Stopwatch()..start();
    var result = await func();
    var delta = minimumDuration - stopwatch.elapsed;
    if (delta > Duration.zero) {
      await Future.delayed(delta);
    }
    return result;
  }
}
