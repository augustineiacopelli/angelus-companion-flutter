import 'package:flutter/material.dart';

import '../widgets/quiet_page.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuietPage(
      title: 'About',
      children: <Widget>[
        Prose(
          'The Angelus is a short devotion prayed three times a day, at six in '
          'the morning, at noon, and at six in the evening. It recalls the '
          'moment the angel greeted Mary and she gave her consent, and through '
          'that consent the Word was made flesh. Praying it takes about a '
          'minute.',
        ),
        PageLabel('THE HOURS'),
        Prose(
          'For centuries a bell rang in the parish at each of these hours, and '
          'whoever heard it stopped what they were doing and prayed. The work '
          'waited. That is the entire idea, and it is why this app rings '
          'rather than reminds.',
        ),
        PageLabel('THE BELLS'),
        Prose(
          'Angelus Companion keeps the three hours and sounds a bell at each '
          'one. Any of them can be silenced in Settings, or all of them. '
          'Nothing here asks you to make an account, and nothing is required '
          'of you but the minute.',
        ),
        PageLabel('THIS APP'),
        Prose(
          'Angelus Companion is made by Augustine Iacopelli. It is one '
          "person's work, built slowly and in the open. It collects nothing "
          'about you. If something in it annoys you, that is the most useful '
          'thing you could tell me.',
        ),
        Coda('Et Verbum caro factum est.'),
      ],
    );
  }
}