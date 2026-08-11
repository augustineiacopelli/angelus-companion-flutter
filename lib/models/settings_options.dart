/// The choices offered by the two settings pickers. These are enhanced enums:
/// each constant carries its own fields, so the display copy and the numeric
/// scale live with the value rather than in a switch statement somewhere else.
enum BellVoice {
  solesmes('Solesmes', 'A single deep bronze bell, left to fade.'),
  village('Village', 'Smaller and brighter, as if heard across a field.'),
  triple('Triple', 'Three strokes, three times, and then nine.'),
  silence('Silence', 'No bell. The hour arrives quietly.');

  const BellVoice(this.label, this.description);

  final String label;
  final String description;
}

enum PrayerTextSize {
  small('Small', 0.9),
  medium('Medium', 1.0),
  large('Large', 1.15),
  largest('Largest', 1.3);

  const PrayerTextSize(this.label, this.scale);

  final String label;

  /// Multiplier applied to the prayer text sizes carried by the theme.
  final double scale;
}