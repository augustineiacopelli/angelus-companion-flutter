# Bell audio

`solesmes.wav`, `village.wav`, and `triple.wav` are real church bell
recordings, sourced 2026-08-20. `lib/app/bell_player.dart` and
`pubspec.yaml` reference them by name; nothing else needs to change if
they are ever replaced.

All three are excerpts of three individual bells recorded at the
Samariterkirche, Berlin, by Wikimedia Commons contributor Pete w.
("Strike tone of the church bell" series), CC BY-SA 4.0. Source files:
- https://commons.wikimedia.org/wiki/File:Samariter_Church_Bell_I_(Es).ogg
- https://commons.wikimedia.org/wiki/File:Samariter_Church_Bell_II_(g).ogg
- https://commons.wikimedia.org/wiki/File:Samariter_Church_Bell_III_(b).ogg

Each original is a single struck bell left to ring out for ~20 seconds;
the bundled files are trimmed excerpts (with a short synthetic fade-out
so the cut isn't audible as a click) rather than the full recordings, to
keep asset size down. Bell I (Es, the deepest of the three) became
`solesmes.wav`; Bell III (b, the brightest) became `village.wav`; Bell II
(g, the middle voice) became `triple.wav`, trimmed to a single ~1.3s
stroke since `BellPlayer` sequences it into the traditional
three-three-three-and-nine pattern in code rather than needing a
pre-mixed recording.

CC BY-SA 4.0 requires attribution, which lives in the About screen
("THE BELL RECORDINGS" section) rather than here, since that is what a
user actually sees. If any of these three files are replaced, update
that attribution too — remove it if the replacement is CC0/public domain
(Pixabay's no-attribution sound effects, or Freesound filtered to CC0,
are still the easiest path for that), or swap in the new source's credit
if not.

`BellVoice.silence` has no file and needs none; `BellPlayer` no-ops on it.
