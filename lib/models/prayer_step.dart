/// A single station in the Angelus. A step is either a versicle and response
/// pair or a body of prayer text; the screen renders whichever fields are set.
class PrayerStep {
  const PrayerStep({
    required this.label,
    this.versicle,
    this.response,
    this.body,
  });

  final String label;
  final String? versicle;
  final String? response;
  final String? body;
}

const String _hailMary =
    'Hail Mary, full of grace, the Lord is with thee; blessed art thou among '
    'women, and blessed is the fruit of thy womb, Jesus.\n\n'
    'Holy Mary, Mother of God, pray for us sinners, now and at the hour of our '
    'death. Amen.';

const String _collect =
    'Pour forth, we beseech Thee, O Lord, Thy grace into our hearts; that we, '
    'to whom the Incarnation of Christ, Thy Son, was made known by the message '
    'of an angel, may by His Passion and Cross be brought to the glory of His '
    'Resurrection. Through the same Christ our Lord. Amen.';

const List<PrayerStep> angelus = <PrayerStep>[
  PrayerStep(
    label: 'THE ANNUNCIATION',
    versicle: 'The Angel of the Lord declared unto Mary,',
    response: 'And she conceived of the Holy Spirit.',
  ),
  PrayerStep(label: 'HAIL MARY', body: _hailMary),
  PrayerStep(
    label: 'THE HANDMAID',
    versicle: 'Behold the handmaid of the Lord,',
    response: 'Be it done unto me according to thy word.',
  ),
  PrayerStep(label: 'HAIL MARY', body: _hailMary),
  PrayerStep(
    label: 'THE WORD MADE FLESH',
    versicle: 'And the Word was made Flesh,',
    response: 'And dwelt among us.',
  ),
  PrayerStep(label: 'HAIL MARY', body: _hailMary),
  PrayerStep(
    label: 'PRAY FOR US',
    versicle: 'Pray for us, O holy Mother of God,',
    response: 'That we may be made worthy of the promises of Christ.',
  ),
  PrayerStep(label: 'LET US PRAY', body: _collect),
];