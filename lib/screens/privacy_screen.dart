import 'package:flutter/material.dart';

import '../widgets/quiet_page.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuietPage(
      title: 'Privacy',
      children: <Widget>[
        Prose(
          'Angelus Companion collects nothing about you. There is no account '
          'to create, no sign-in, no analytics, no advertising, and no '
          'third-party tracking of any kind.',
        ),
        PageLabel('WHAT STAYS ON YOUR DEVICE'),
        Prose(
          'Your settings, meaning which bells are on, which sound plays, and '
          'how large the prayer text is, are stored on your phone and nowhere '
          'else. Your prayer is not recorded. Nothing is transmitted, because '
          'there is nowhere for it to go.',
        ),
        PageLabel('NOTIFICATIONS'),
        Prose(
          "The bells are scheduled locally by your phone's own operating "
          'system. Granting notification permission lets the app place those '
          'reminders. It gives the app access to nothing else.',
        ),
        PageLabel('IF THIS EVER CHANGES'),
        Prose(
          'If some future version needs to send or store anything at all, this '
          'page will say so plainly before that version ships, and you will be '
          'asked first.',
        ),
        Coda('Last updated 10 August 2026.'),
      ],
    );
  }
}