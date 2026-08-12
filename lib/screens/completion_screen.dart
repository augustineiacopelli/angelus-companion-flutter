import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// The end of the Angelus. Pushed on top of the prayer rather than replacing
/// it, so the system back button and the back gesture return to the final
/// station; a stray tap while reading the collect should not cost the whole
/// prayer. [onReturn] is the deliberate exit, and the screen that pushed this
/// one owns what that means for the navigation stack.
class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.onReturn});

  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 160,
                  height: 2,
                  color: AngelusColors.gold.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 56),
                Text(
                  'May the divine assistance remain always with us.',
                  textAlign: TextAlign.center,
                  style: text.bodyMedium?.copyWith(color: AngelusColors.ivory),
                ),
                const SizedBox(height: 28),
                Text(
                  'And may the souls of the faithful departed, through the '
                  'mercy of God, rest in peace. Amen.',
                  textAlign: TextAlign.center,
                  style: text.bodySmall?.copyWith(color: AngelusColors.gold),
                ),
                const SizedBox(height: 88),
                TextButton(
                  onPressed: onReturn,
                  child: Text('RETURN', style: text.labelLarge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}