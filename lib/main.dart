import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// Stretches every animation by this factor, standing in for the slow
/// animations toggle in DevTools, which is unavailable whenever the app is
/// run with --no-dds. Compile-time, defaults to normal speed, so it cannot
/// reach a release build by accident.
///
///   flutter run --no-dds --dart-define=slowmo=5
const int _slowMotion = int.fromEnvironment('slowmo', defaultValue: 1);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timeDilation = _slowMotion < 1 ? 1.0 : _slowMotion.toDouble();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const AngelusApp());
}

class AngelusApp extends StatelessWidget {
  const AngelusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Angelus Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}