# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Angelus Companion is a Flutter app that walks a user through the eight stations of the Angelus prayer and reminds them of the morning, noon, and evening bell. It is built solo, in public, with a running development journal in `BUILD_LOG.md` (dated entries, newest first). Read the most recent entries there before touching animation/motion code, navigation, or Windows tooling — the reasoning behind non-obvious decisions (and prior dead ends) is recorded there, not in code comments.

## Commands

```
flutter run                          # run on a connected device/emulator
flutter run --no-dds                 # see "DDS / hot reload" below
flutter run --dart-define=slowmo=5   # stretch all animation timing 5x for tuning (see lib/main.dart)
flutter analyze                      # static analysis (flutter_lints, package:flutter_lints/flutter.yaml)
flutter test                         # run all tests
flutter test test/widget_test.dart   # run a single test file
```

There is one test file (`test/widget_test.dart`). When writing widget tests against this app's screens, use `tester.pump(duration)` rather than `tester.pumpAndSettle()` — several screens have repeating/looping animations (e.g. the home screen's breathing halo), and `pumpAndSettle` hangs forever waiting for them to finish.

### DDS / hot reload (Windows-specific)

This project has hit recurring Dart VM service / DDS connection failures on Windows. If a run fails to attach or DevFS fails to sync:

1. Check `netstat -ano | Select-String "8181"` before relaunching — if anything is bound or even in `TIME_WAIT`, Flutter will silently fall back to a random ephemeral port rather than failing loudly, and that port is often the one blocked by this machine's endpoint security.
2. Prefer relaunching on pinned alternates (`8183`/`8184`) over letting Flutter choose.
3. If DDS itself won't attach on any port, run with `--no-dds`. This costs DevTools (and thus the slow-motion animation toggle — use `--dart-define=slowmo=N` instead, see `lib/main.dart`) but hot reload, hot restart, and console output all still work.
4. `adb kill-server` / `adb start-server` fixes stale forwards left behind by a previous session (a common cause of first-run-of-the-day DevFS failures).
5. New imports require a full hot **restart** (`R`), not hot reload (`r`).

## Architecture

**Everything is a widget; there is no markup layer.** `android/`, `ios/`, etc. are real host projects, not scaffolding — treat `lib/` as the entire application.

### Motion is centralized

`lib/app/motion.dart` (`Motion` class) is the single place that declares every `Duration` and `Curve` used in the app. Nothing outside it should write a raw `Duration(...)` or reference a `Curves` constant for a *transition* — the one deliberate exception is the home screen's six-second breathing-halo loop, which is an ambient animation rather than a transition. When changing timing, edit `Motion`, not the call site.

Durations are built from a 300ms "beat": a small acknowledgement is one beat, a station-to-station change in the prayer is two, arriving at a screen is two, text receding is three. `lib/app/fade_route.dart` (`fadeRoute`) is the one page-transition builder used everywhere `Navigator.push`/`pushReplacement` is called — a slow cross-fade, deliberately not Material's default slide.

If you touch `AnimatedSwitcher` timing: `switchInCurve`/`switchOutCurve` are both anchored to `Interval(0.5, 1.0, ...)` (`Motion.depart`/`Motion.arrive`) rather than the plain curve each half would suggest. This sequences outgoing/incoming children (outgoing empties in the first half, incoming fills in the second) instead of cross-fading them on top of each other, which otherwise makes two prayer stations legible simultaneously through the middle of the change.

### Theme

`lib/theme/app_theme.dart` defines the full palette (`AngelusColors`: night/ivory/muted/gold) and a Cormorant Garamond `TextTheme` built via `google_fonts`. Screens pull colors from `AngelusColors` directly and text styles from `Theme.of(context).textTheme` (`displaySmall`, `bodyMedium`, `bodySmall`, `labelSmall`, `labelLarge` each carry a specific meaning — check `app_theme.dart` before adding a new one rather than hardcoding a style).

### Shared page shapes

- `lib/widgets/quiet_page.dart` (`QuietPage`, `Prose`, `Coda`, `PageLabel`) — the shape for any scrollable reading screen with a back arrow and title (About, Privacy).
- `lib/widgets/choice_page.dart` (`ChoicePage<T>`, `ChoiceOption<T>`) — built on `QuietPage`, for any screen offering a short list of mutually-exclusive choices (Bell voice, Text size). **Pattern to preserve**: `ChoicePage` holds its own selection state and calls `onSelected` immediately on every tap, rather than returning a value via `Navigator.pop(result)`. A pushed route does not rebuild when the pushing screen's `setState` runs, so passing the value back down would freeze the checkmark; and popping-with-a-result only covers the back arrow, not the hardware back button or edge-swipe gesture (which return `null`). Reporting upward makes all three exit paths behave identically. Follow this pattern for any new picker.

### Prayer flow and navigation

- `lib/models/prayer_step.dart` — the Angelus text as a `const List<PrayerStep>`, one station per entry (`versicle`/`response` pair or plain `body`). Timing/audio for Week 2+ attaches to this structure rather than to screen layout.
- `lib/screens/prayer_screen.dart` — tap or horizontal swipe advances/retreats through stations; on the last station it replaces itself with the completion screen.
- `lib/screens/completion_screen.dart` is reached via `Navigator.pushReplacement`, not `push`. This is deliberate: the prayer route is disposed at the transition, so the system back button, the edge-swipe gesture, and the completion screen's own RETURN button all land on home instead of back on the finished prayer. If you add a new terminal screen in a flow, replicate `pushReplacement` rather than `push` unless you specifically want the previous screen still reachable by going back.
- Corollary bug to know about: don't resolve `Navigator.of(context)` lazily inside a callback that fires after a `pushReplacement` — the pushing route's `State` is unmounted by then. Resolve the `NavigatorState` once up front and close over that instead (see `_PrayerScreenState._finish`).
- `lib/models/settings_options.dart` — `BellVoice` and `PrayerTextSize` are enhanced enums carrying their own display copy (and, for text size, a scale multiplier) as fields, rather than switching on the enum elsewhere.

### State: currently local only

Settings (bell voice, text size, toggles) live as local `State` in `SettingsScreen` and are not yet persisted or threaded through to other screens — e.g. the chosen text size does not yet affect the prayer screen. This is an intentional gap, not a bug: an app-level settings holder is planned once persistence lands, and building it before that would mean building it twice. Don't wire cross-screen settings propagation without also adding persistence, unless asked.

### Accessibility

Instructional copy that fades to nothing (e.g. prayer screen's "tap to continue") should be wrapped in `ExcludeSemantics` once invisible — screen readers were observed reading fully-transparent hint text aloud. Choice rows use `Semantics(button: true, selected: ...)` rather than relying on a Material radio/checkbox for selected-state announcement.

## External Data Fetching

- DO NOT use MCP servers for fetching web content or API data.
- For all web-based lookups, use the CLI command: `curl -sL [URL]`.
