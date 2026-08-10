import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A scrollable reading page with a back control and a title. The
/// informational screens all share one shape: leave, read, return.
class QuietPage extends StatelessWidget {
  const QuietPage({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 88),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AngelusColors.muted,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(title, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 48),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// A paragraph of reading text. Ivory rather than the muted default, because
/// muted at this size is comfortable for two lines and not for twenty.
class Prose extends StatelessWidget {
  const Prose(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AngelusColors.ivory),
      ),
    );
  }
}

/// A quiet closing line. Italic, muted, and set apart.
class Coda extends StatelessWidget {
  const Coda(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

/// A small tracked-out section label, matching the settings screen.
class PageLabel extends StatelessWidget {
  const PageLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 22),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}