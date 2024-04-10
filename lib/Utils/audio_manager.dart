import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  late AudioPlayer _audioPlayer;
  static final AudioManager _singleton = AudioManager._internal();

  factory AudioManager() {
    return _singleton;
  }

  AudioManager._internal() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> playAudio(String fileName) async {
    _audioPlayer.audioCache.prefix = 'lib/assets/audio/';
    _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    if (fileName == 'sound0.mp3') {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      _audioPlayer.setReleaseMode(ReleaseMode.release);
    }
    _audioPlayer.play(AssetSource(fileName), mode: PlayerMode.lowLatency);
    _audioPlayer.audioCache.clearAll();
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
