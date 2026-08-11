import 'package:flutter/material.dart';

import '../models/prayer_step.dart';
import '../models/settings_options.dart';
import '../theme/app_theme.dart';
import '../widgets/choice_page.dart';

class TextSizeScreen extends StatelessWidget {
  const TextSizeScreen({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final PrayerTextSize selected;
  final ValueChanged<PrayerTextSize> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoicePage<PrayerTextSize>(
      title: 'Text size',
      initialSelection: selected,
      onSelected: onSelected,
      options: <ChoiceOption<PrayerTextSize>>[
        for (final PrayerTextSize size in PrayerTextSize.values)
          ChoiceOption<PrayerTextSize>(value: size, label: size.label),
      ],
      footerBuilder: (BuildContext context, PrayerTextSize selection) =>
          _Preview(size: selection),
    );
  }
}

/// The first station, rendered at the chosen scale. A text size control that
/// cannot be seen is a guess, so the preview shows the real versicle and
/// response in their real colors.
class _Preview extends StatelessWidget {
  const _Preview({required this.size});

  final PrayerTextSize size;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final PrayerStep step = angelus.first;
    final double versicleSize = (text.bodyMedium?.fontSize ?? 17) * size.scale;
    final double responseSize = (text.bodySmall?.fontSize ?? 16) * size.scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 1,
          margin: const EdgeInsets.only(top: 36, bottom: 44),
          color: AngelusColors.muted.withValues(alpha: 0.18),
        ),
        Text(step.label, textAlign: TextAlign.center, style: text.labelSmall),
        const SizedBox(height: 40),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          textAlign: TextAlign.center,
          style: text.bodyMedium!.copyWith(
            color: AngelusColors.ivory,
            fontSize: versicleSize,
          ),
          child: Text(step.versicle!),
        ),
        const SizedBox(height: 28),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          textAlign: TextAlign.center,
          style: text.bodySmall!.copyWith(
            color: AngelusColors.gold,
            fontSize: responseSize,
          ),
          child: Text(step.response!),
        ),
      ],
    );
  }
}