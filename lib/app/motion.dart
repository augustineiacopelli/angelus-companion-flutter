import 'package:flutter/animation.dart';

/// Every duration and curve in the app is declared here. Nothing elsewhere
/// should write a `Duration` or name a `Curves` constant directly, so that
/// tuning the tempo of the whole app is one edit in one place.
///
/// The unit is a beat of 300ms. A small acknowledgement is one beat, a
/// station of the prayer giving way to the next is two, arriving at a screen
/// is two, and copy that has done its work recedes over three.
class Motion {
  const Motion._();

  /// A checkmark, a progress tick: the app confirming it heard the tap.
  static const Duration mark = Duration(milliseconds: 300);

  /// One station of the Angelus giving way to the next. Spent as one beat
  /// leaving and one beat arriving, never both at once.
  static const Duration passage = Duration(milliseconds: 700);

  /// Arriving at a screen.
  static const Duration veil = Duration(milliseconds: 600);

  /// Leaving one. Deliberately not a whole number of beats: two makes
  /// departure feel like it needs permission, one reads as snapping.
  static const Duration unveil = Duration(milliseconds: 450);

  /// Instructional copy withdrawing once it is no longer needed. Slow enough
  /// that the eye is not pulled back to it on the way out.
  static const Duration recede = Duration(milliseconds: 900);

  /// The reveal of the completion, lead-in included. See CompletionScreen.
  static const Duration benediction = Duration(milliseconds: 1900);

  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
  static const Curve both = Curves.easeInOut;

  /// Paired curves for [AnimatedSwitcher]. Anchoring both to the top half of
  /// the interval sequences the transition: the outgoing child's controller
  /// runs backward and empties during the first half of [passage], the
  /// incoming child's runs forward and fills during the second. Without this
  /// the two children are cross-faded on top of each other and two prayers
  /// are legible at once through the middle of every change.
  static const Curve depart = Interval(0.5, 1.0, curve: both);
  static const Curve arrive = Interval(0.5, 1.0, curve: both);
}