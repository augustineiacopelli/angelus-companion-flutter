import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'quiet_page.dart';

/// One selectable option on a [ChoicePage].
class ChoiceOption<T> {
  const ChoiceOption({
    required this.value,
    required this.label,
    this.description,
  });

  final T value;
  final String label;
  final String? description;
}

/// A reading page offering a short list of choices, exactly one of which is
/// held. The page keeps the live selection itself and reports every change
/// upward through [onSelected], so the arrow, the system back button, and the
/// back gesture all end in the same place.
class ChoicePage<T> extends StatefulWidget {
  const ChoicePage({
    super.key,
    required this.title,
    required this.options,
    required this.initialSelection,
    required this.onSelected,
    this.footerBuilder,
  });

  final String title;
  final List<ChoiceOption<T>> options;
  final T initialSelection;
  final ValueChanged<T> onSelected;

  /// Optional content below the list, rebuilt on every change so a picker can
  /// show what the choice actually looks like.
  final Widget Function(BuildContext context, T selection)? footerBuilder;

  @override
  State<ChoicePage<T>> createState() => _ChoicePageState<T>();
}

class _ChoicePageState<T> extends State<ChoicePage<T>> {
  late T _selection = widget.initialSelection;

  void _choose(T value) {
    if (value == _selection) return;
    setState(() => _selection = value);
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return QuietPage(
      title: widget.title,
      children: <Widget>[
        for (final ChoiceOption<T> option in widget.options)
          _ChoiceRow<T>(
            option: option,
            selected: option.value == _selection,
            onTap: () => _choose(option.value),
          ),
        if (widget.footerBuilder != null)
          widget.footerBuilder!(context, _selection),
      ],
    );
  }
}

class _ChoiceRow<T> extends StatelessWidget {
  const _ChoiceRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final ChoiceOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      option.label,
                      style:
                          text.bodyMedium?.copyWith(color: AngelusColors.ivory),
                    ),
                    if (option.description != null) ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        option.description!,
                        style: text.bodySmall?.copyWith(fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              AnimatedOpacity(
                opacity: selected ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(Icons.check, size: 18, color: AngelusColors.gold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}