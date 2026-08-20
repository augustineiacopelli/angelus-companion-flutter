# Bell audio

`solesmes.wav`, `village.wav`, and `triple.wav` are silent placeholders
generated for the pipeline, not real bell recordings. Replace them with
actual bell sounds under these exact filenames and nothing else needs to
change — `lib/app/bell_player.dart` and `pubspec.yaml` already reference
them by name.

Sourcing notes (see BUILD_LOG.md 2026-08-20):
- Pixabay (pixabay.com/sound-effects) — royalty-free, no attribution
  required, safest for a shipping app.
- Freesound.org — larger library, more character, but most results are
  CC-BY and need a credit somewhere in the app (About screen works).
  Filter to CC0 to skip that requirement.

`triple.wav` only needs a single bell stroke — `BellPlayer` sequences it
into the traditional three-three-three-and-nine pattern in code rather
than needing a pre-mixed recording.

`BellVoice.silence` has no file and needs none; `BellPlayer` no-ops on it.
