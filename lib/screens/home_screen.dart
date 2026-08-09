import 'dart:async';

import 'package:flutter/material.dart';

import '../app/fade_route.dart';
import '../theme/app_theme.dart';
import 'prayer_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const List<int> _bellHours = <int>[6, 12, 18];

  late final AnimationController _breath;
  late final Timer _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _breath = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _ticker = Timer.periodic(const Duration(seconds: 20), (Timer _) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    _breath.dispose();
    super.dispose();
  }

  DateTime get _nextBell {
    for (final int hour in _bellHours) {
      final DateTime candidate =
          DateTime(_now.year, _now.month, _now.day, hour);
      if (candidate.isAfter(_now)) {
        return candidate;
      }
    }
    final DateTime tomorrow = _now.add(const Duration(days: 1));
    return DateTime(
        tomorrow.year, tomorrow.month, tomorrow.day, _bellHours.first);
  }

  String get _bellName {
    switch (_nextBell.hour) {
      case 6:
        return 'The Morning Angelus';
      case 12:
        return 'The Noonday Angelus';
      default:
        return 'The Evening Angelus';
    }
  }

  String get _untilNextBell {
    final Duration remaining = _nextBell.difference(_now);
    final int hours = remaining.inHours;
    final int minutes = remaining.inMinutes.remainder(60);
    final String hourWord = hours == 1 ? 'hour' : 'hours';
    final String minuteWord = minutes == 1 ? 'minute' : 'minutes';

    if (hours == 0 && minutes == 0) {
      return 'about to ring';
    }
    if (hours == 0) {
      return 'in $minutes $minuteWord';
    }
    if (minutes == 0) {
      return 'in $hours $hourWord';
    }
    return 'in $hours $hourWord and $minutes $minuteWord';
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final String bellTime = TimeOfDay.fromDateTime(_nextBell).format(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              const Spacer(flex: 2),
              Text('ANGELUS COMPANION', style: text.labelSmall),
              const Spacer(flex: 2),
              _BreathingHalo(animation: _breath),
              const Spacer(flex: 2),
              Text(
                _bellName,
                style: text.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Text(
                '$bellTime, $_untilNextBell',
                style: text.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              Text(
                'The Angel of the Lord declared unto Mary.',
                style: text.bodySmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              _BeginButton(
                onPressed: () => Navigator.of(context).push(
                  fadeRoute(const PrayerScreen()),
                ),
              ),
              const Spacer(flex: 1),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  fadeRoute(const SettingsScreen()),
                ),
                child: Text('Settings', style: text.bodyMedium),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreathingHalo extends StatelessWidget {
  const _BreathingHalo({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double t = Curves.easeInOut.transform(animation.value);
        return SizedBox(
          width: 224,
          height: 224,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 180 + (t * 34),
                height: 180 + (t * 34),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      AngelusColors.gold.withValues(alpha: 0.16 + (t * 0.10)),
                      AngelusColors.gold.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        AngelusColors.gold.withValues(alpha: 0.40 + (t * 0.25)),
                    width: 1,
                  ),
                ),
              ),
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AngelusColors.gold.withValues(alpha: 0.55 + (t * 0.30)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BeginButton extends StatelessWidget {
  const _BeginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AngelusColors.ivory,
        side: BorderSide(color: AngelusColors.gold.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 20),
        shape: const StadiumBorder(),
      ),
      child: Text('BEGIN', style: Theme.of(context).textTheme.labelLarge),
    );
  }
}