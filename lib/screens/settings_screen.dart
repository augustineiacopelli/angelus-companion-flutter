import 'package:flutter/material.dart';

import '../app/fade_route.dart';
import '../theme/app_theme.dart';
import 'about_screen.dart';
import 'privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _morning = true;
  bool _noon = true;
  bool _evening = true;
  bool _vibrate = false;
  bool _keepAwake = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 64),
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back,
                        size: 20, color: AngelusColors.muted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Settings', style: text.displaySmall),
            const SizedBox(height: 48),
            const _SectionHeader('THE BELLS'),
            _SwitchRow(
              title: 'Morning',
              detail: '6:00 AM',
              value: _morning,
              onChanged: (bool v) => setState(() => _morning = v),
            ),
            _SwitchRow(
              title: 'Midday',
              detail: '12:00 PM',
              value: _noon,
              onChanged: (bool v) => setState(() => _noon = v),
            ),
            _SwitchRow(
              title: 'Evening',
              detail: '6:00 PM',
              value: _evening,
              onChanged: (bool v) => setState(() => _evening = v),
            ),
            const SizedBox(height: 40),
            const _SectionHeader('SOUND'),
            const _NavRow(title: 'Bell', detail: 'Solesmes'),
            _SwitchRow(
              title: 'Vibrate',
              value: _vibrate,
              onChanged: (bool v) => setState(() => _vibrate = v),
            ),
            const SizedBox(height: 40),
            const _SectionHeader('PRAYER'),
            const _NavRow(title: 'Text size', detail: 'Medium'),
            _SwitchRow(
              title: 'Keep screen awake',
              value: _keepAwake,
              onChanged: (bool v) => setState(() => _keepAwake = v),
            ),
            const SizedBox(height: 40),
            const _SectionHeader('ABOUT'),
            _NavRow(
              title: 'About Angelus Companion',
              onTap: () => Navigator.of(context).push(
                fadeRoute<void>(const AboutScreen()),
              ),
            ),
            _NavRow(
              title: 'Privacy',
              onTap: () => Navigator.of(context).push(
                fadeRoute<void>(const PrivacyScreen()),
              ),
            ),
            const _NavRow(title: 'Version', detail: '1.0.0'),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(title, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.detail,
  });

  final String title;
  final String? detail;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: text.bodyMedium?.copyWith(color: AngelusColors.ivory),
                ),
                if (detail != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(detail!, style: text.bodySmall?.copyWith(fontSize: 14)),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) =>
                  states.contains(WidgetState.selected)
                      ? AngelusColors.night
                      : AngelusColors.muted,
            ),
            trackColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) =>
                  states.contains(WidgetState.selected)
                      ? AngelusColors.gold
                      : Colors.transparent,
            ),
            trackOutlineColor:
                WidgetStateProperty.all<Color>(AngelusColors.muted),
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({required this.title, this.detail, this.onTap});

  final String title;
  final String? detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: text.bodyMedium?.copyWith(color: AngelusColors.ivory),
              ),
            ),
            if (detail != null)
              Text(detail!, style: text.bodySmall?.copyWith(fontSize: 14)),
            if (onTap != null) ...<Widget>[
              const SizedBox(width: 12),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: AngelusColors.muted.withValues(alpha: 0.6),
              ),
            ],
          ],
        ),
      ),
    );
  }
}