import 'package:audioplayers/audioplayers.dart';

import '../models/settings_options.dart';

/// Plays the bell tied to a [BellVoice]. [BellVoice.silence] is a real
/// choice, not an error, so it no-ops rather than throwing.
///
/// The gap between strokes below is audio cadence, not a UI transition — it
/// never animates a widget property or a screen change — so it does not
/// belong in Motion (lib/app/motion.dart) alongside the app's page and
/// station timing.
class BellPlayer {
  BellPlayer() : _player = AudioPlayer();

  final AudioPlayer _player;

  static const Map<BellVoice, String> _assets = <BellVoice, String>{
    BellVoice.solesmes: 'audio/solesmes.wav',
    BellVoice.village: 'audio/village.wav',
    BellVoice.triple: 'audio/triple.wav',
  };

  static const Duration _strokeGap = Duration(milliseconds: 550);
  static const Duration _groupGap = Duration(milliseconds: 1100);

  /// Plays [voice] once, for a picker row's audition control.
  Future<void> audition(BellVoice voice) => play(voice);

  /// Plays [voice]'s bell: once for a single stroke, or the traditional
  /// three-three-three-and-nine pattern for [BellVoice.triple]. No-ops for
  /// [BellVoice.silence].
  Future<void> play(BellVoice voice) async {
    final String? asset = _assets[voice];
    if (asset == null) return;

    if (voice != BellVoice.triple) {
      await _player.play(AssetSource(asset));
      return;
    }

    for (int group = 0; group < 3; group++) {
      for (int stroke = 0; stroke < 3; stroke++) {
        await _player.play(AssetSource(asset));
        await Future<void>.delayed(_strokeGap);
      }
      await Future<void>.delayed(_groupGap);
    }
    for (int stroke = 0; stroke < 9; stroke++) {
      await _player.play(AssetSource(asset));
      await Future<void>.delayed(_strokeGap);
    }
  }

  void dispose() => _player.dispose();
}
