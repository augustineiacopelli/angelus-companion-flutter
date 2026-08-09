import 'package:flutter/material.dart';

import '../models/prayer_step.dart';
import '../theme/app_theme.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  int _index = 0;
  bool _complete = false;

  void _advance() {
    if (_complete) return;
    setState(() {
      if (_index < angelus.length - 1) {
        _index++;
      } else {
        _complete = true;
      }
    });
  }

  void _retreat() {
    setState(() {
      if (_complete) {
        _complete = false;
      } else if (_index > 0) {
        _index--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _advance,
        onHorizontalDragEnd: (DragEndDetails details) {
          final double velocity = details.primaryVelocity ?? 0;
          if (velocity < -100) {
            _advance();
          } else if (velocity > 100) {
            _retreat();
          }
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _TopBar(
                onClose: () => Navigator.of(context).pop(),
                showProgress: !_complete,
                index: _index,
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: _complete
                      ? const _Completion(key: ValueKey<String>('complete'))
                      : _StepView(
                          key: ValueKey<int>(_index),
                          step: angelus[_index],
                        ),
                ),
              ),
              AnimatedOpacity(
                opacity: (_index == 0 && !_complete) ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    'tap to continue',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onClose,
    required this.showProgress,
    required this.index,
  });

  final VoidCallback onClose;
  final bool showProgress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: onClose,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.close, size: 20, color: AngelusColors.muted),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: showProgress ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(angelus.length, (int i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 2,
                    width: 14,
                    color: i <= index
                        ? AngelusColors.gold
                        : AngelusColors.muted.withValues(alpha: 0.25),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

class _StepView extends StatelessWidget {
  const _StepView({super.key, required this.step});

  final PrayerStep step;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(step.label, style: text.labelSmall),
            const SizedBox(height: 48),
            if (step.versicle != null) ...<Widget>[
              Text(
                step.versicle!,
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(color: AngelusColors.ivory),
              ),
              const SizedBox(height: 28),
              Text(
                step.response!,
                textAlign: TextAlign.center,
                style: text.bodySmall?.copyWith(color: AngelusColors.gold),
              ),
            ],
            if (step.body != null)
              Text(
                step.body!,
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(color: AngelusColors.ivory),
              ),
          ],
        ),
      ),
    );
  }
}

class _Completion extends StatelessWidget {
  const _Completion({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Amen.', style: text.displaySmall),
            const SizedBox(height: 32),
            Text(
              'May the divine assistance remain always with us.',
              textAlign: TextAlign.center,
              style: text.bodySmall,
            ),
            const SizedBox(height: 72),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('RETURN', style: text.labelLarge),
            ),
          ],
        ),
      ),
    );
  }
}