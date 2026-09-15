import 'package:just_audio/just_audio.dart';

class Sonido {
  Future<void> playSound() async {
    final player = AudioPlayer();
    try {
      await player.setAsset(
        'assets/audio/sonido_error.mp3',
      ); // Reemplaza con la ruta de tu archivo
      player.play();
    } catch (e) {
      print("Error al reproducir el sonido: $e");
    }
  }
}
