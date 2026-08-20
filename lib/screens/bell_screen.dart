import 'package:flutter/material.dart';

import '../app/bell_player.dart';
import '../models/settings_options.dart';
import '../widgets/choice_page.dart';
import '../widgets/quiet_page.dart';

class BellScreen extends StatefulWidget {
  const BellScreen({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final BellVoice selected;
  final ValueChanged<BellVoice> onSelected;

  @override
  State<BellScreen> createState() => _BellScreenState();
}

class _BellScreenState extends State<BellScreen> {
  final BellPlayer _player = BellPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChoicePage<BellVoice>(
      title: 'Bell',
      initialSelection: widget.selected,
      onSelected: widget.onSelected,
      options: <ChoiceOption<BellVoice>>[
        for (final BellVoice voice in BellVoice.values)
          ChoiceOption<BellVoice>(
            value: voice,
            label: voice.label,
            description: voice.description,
            onAudition:
                voice == BellVoice.silence ? null : () => _player.audition(voice),
          ),
      ],
      footerBuilder: (BuildContext context, BellVoice selection) =>
          const Coda('One bell keeps all three hours.'),
    );
  }
}