import 'package:flutter/material.dart';

/// A push transition that cross-fades rather than sliding. Slower than
/// Material's default on purpose; the app should never feel hurried.
Route<T> fadeRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 650),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, Animation<double> animation, _, Widget child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}