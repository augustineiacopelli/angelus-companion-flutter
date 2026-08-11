import 'package:flutter/material.dart';

import '../models/settings_options.dart';
import '../widgets/choice_page.dart';
import '../widgets/quiet_page.dart';

class BellScreen extends StatelessWidget {
  const BellScreen({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final BellVoice selected;
  final ValueChanged<BellVoice> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoicePage<BellVoice>(
      title: 'Bell',
      initialSelection: selected,
      onSelected: onSelected,
      options: <ChoiceOption<BellVoice>>[
        for (final BellVoice voice in BellVoice.values)
          ChoiceOption<BellVoice>(
            value: voice,
            label: voice.label,
            description: voice.description,
          ),
      ],
      footerBuilder: (BuildContext context, BellVoice selection) =>
          const Coda('One bell keeps all three hours.'),
    );
  }
}