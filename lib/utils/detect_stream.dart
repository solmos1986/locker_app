import 'dart:developer';

class DetectStream {
  Future<String> detectStreamLog(
    Stream<String> stream,
    String verificar,
  ) async {
    var result = '';
    try {
      await for (final value in stream) {
        log('valor $value comparar $verificar');
        if (verificar == value) {
          result = value;
          throw Exception('Intentional exception');
        }
      }
    } catch (e) {
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
