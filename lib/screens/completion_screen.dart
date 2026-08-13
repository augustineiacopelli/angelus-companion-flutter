import 'package:flutter/material.dart';

import '../app/motion.dart';
import '../theme/app_theme.dart';

/// The end of the Angelus. Pushed with `pushReplacement`, so the prayer route
/// is disposed at the transition and every backward path from here, whether
/// the RETURN control, the system back button or the edge gesture, lands on
/// home. [onReturn] is the deliberate exit, and the screen that pushed this
/// one owns what that means for the navigation stack.
///
/// The screen reveals itself in three movements rather than arriving whole.
/// The first third of the controller is a lead-in matching the route's own
/// fade, held inside the controller rather than scheduled on a timer so that
/// `timeDilation` stretches the whole sequence together.
class CompletionScreen extends StatefulWidget {
  const CompletionScreen({super.key, required this.onReturn});

  final VoidCallback onReturn;

  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _reveal;
  late final CurvedAnimation _rule;
  late final CurvedAnimation _words;
  late final CurvedAnimation _exit;

  @override
  void initState() {
    super.initState();
    _reveal = AnimationController(vsync: this, duration: Motion.benediction);
    // 0.00 to 0.32 is the lead-in, covering the route's own fade.
    _rule = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.32, 0.58, curve: Motion.enter),
    );
    _words = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.45, 0.79, curve: Motion.enter),
    );
    _exit = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.68, 1.0, curve: Motion.enter),
    );
    _reveal.forward();
  }

  @override
  void dispose() {
    _rule.dispose();
    _words.dispose();
    _exit.dispose();
    _reveal.dispose();
    super.dispose();
  }

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
                _DrawnRule(animation: _rule),
                const SizedBox(height: 56),
                FadeTransition(
                  opacity: _words,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'May the divine assistance remain always with us.',
                        textAlign: TextAlign.center,
                        style: text.bodyMedium
                            ?.copyWith(color: AngelusColors.ivory),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'And may the souls of the faithful departed, through '
                        'the mercy of God, rest in peace. Amen.',
                        textAlign: TextAlign.center,
                        style: text.bodySmall
                            ?.copyWith(color: AngelusColors.gold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 88),
                FadeTransition(
                  opacity: _exit,
                  child: TextButton(
                    onPressed: widget.onReturn,
                    child: Text('RETURN', style: text.labelLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The gold rule drawing outward from the center. Scaled rather than sized so
/// that the 160 logical pixels are reserved in layout from the first frame and
/// nothing below it shifts as the line grows.
class _DrawnRule extends StatelessWidget {
  const _DrawnRule({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scaleX: animation.value,
          scaleY: 1,
          child: child,
        );
      },
      child: Container(
        width: 160,
        height: 2,
        color: AngelusColors.gold.withValues(alpha: 0.75),
      ),
    );
  }
}