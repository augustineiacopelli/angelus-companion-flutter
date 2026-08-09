# Angelus Companion — Build Log

## 2026-08-09
Wired home_screen.dart to the prayer and settings screens, adding imports for
fade_route, prayer_screen, and settings_screen and replacing the two empty
callbacks with pushes through fadeRoute. Both screens are now reachable, the
cross-fade reads correctly, all eight stations run through to the completion
state, and the settings switches toggle. Phase 0's screen work is closed.
Hit a DevFS failure on the first run of the day, immediately after Impeller
initialized, with nothing listening on the pinned ports. Cause was stale adb
forwards left behind by the previous session, which survive in the adb server
after Flutter exits. Fix is adb kill-server then start-server. This is now the
first thing to try when DevFS fails on a pinned-port setup, ahead of checking
for port collisions.

## 2026-08-08
Built the prayer and settings screens. The Angelus text lives as a const list
of PrayerStep records in lib/models/prayer_step.dart so that Week 2 attaches
timing and audio to a structure rather than editing layout. Prayer screen is
eight stations with tap and swipe advance, a cross-fade between steps, a thin
segmented progress rule in gold, versicle in ivory and response in gold, and a
completion state. Settings sketches bells, sound, prayer, and about sections
with local state only. Added lib/app/fade_route.dart because Material's default
slide transition reads as a productivity app and a slow cross-fade does not.
Both screens are on disk but not yet reachable. The navigation wiring in
home_screen.dart is incomplete, so BEGIN still does nothing. Stopped here rather
than debugging tired.
Tomorrow, first task: wire home_screen.dart to the two new screens, adding the
three imports, the onPressed on BEGIN, and the settings entry, then hot restart
with R rather than r because new imports do not survive a hot reload. Then
Phase 0 close, comparing both screens against the web version for color,
spacing, and countdown rounding, cleaning the duplicated system path out of the
User PATH variable, and planning Week 1.

## 2026-08-07
Walked the generated project structure, covering what lib actually holds, why android and ios are real host projects rather than scaffolding, what pubspec.yaml governs, and the fact that everything visible is a widget with no markup layer beneath it. Replaced the counter scaffold with the first real Angelus Companion screen. Added google_fonts, created lib/theme/app_theme.dart holding the night, ivory, muted, and gold palette with a Cormorant Garamond text theme, and built lib/screens/home_screen.dart with next bell logic for the six, noon, and six hours, a slowly breathing halo standing in for the bell artwork, and a BEGIN control with no behavior yet. Rewrote main.dart and the default widget test, which was still asserting on the counter. flutter analyze clean and the screen renders correctly on the emulator, with the serif loading and the countdown live.
Also sorted out repository housekeeping. The repo had been left private and is now public, which is what the build-in-public plan assumed all along. Confirmed BUILD_LOG.md is committed at the root of main.
One issue unresolved. The Dart VM service connection fails on every run with a getVersion error on a fresh localhost port, most likely endpoint security on this machine blocking loopback. The app builds, installs, and runs normally, but hot reload and DevTools are unavailable, so every change currently requires a full rebuild. Fixing this is the first priority tomorrow because it slows every session until it is solved.
Learned that pumpAndSettle hangs forever on a repeating animation and pump must be used instead, that flutter run only lists emulators already running and will offer the Windows desktop target this project will never use, and that a FlutterRenderer width of zero means the emulator window is partly off screen rather than anything wrong with the code, fixed with the Windows key and the left arrow.
Tomorrow: fix the VM service connection so hot reload works, which needs adb on the PATH first. Then connect the physical Android device over USB, sketch the prayer and settings screens with no functionality, and compare the home screen against the web version to tune color, spacing, and the countdown rounding.

## 2026-08-06
Created angelus-companion-flutter repo and cloned to ~/dev. Generated Flutter project with org com.augustineiacopelli, bundle id com.augustineiacopelli.angelus_companion. Resolved missing JAVA_HOME for sdkmanager (Android Studio JBR at "C:\Program Files\Android\Android Studio\jbr", now set permanently) and installed the android-35 google_apis_playstore x86_64 system image, which Android Studio had skipped. Created and launched the angelus_pixel emulator. Hello World counter app built and running on emulator, hot reload confirmed at 698ms. Initial scaffold committed and pushed. Physical device testing still outstanding from Phase 0.
Tomorrow: walk the generated project structure — lib, pubspec.yaml, the android and ios folders, what main.dart is actually doing — then begin a rough recreation of one Angelus Companion web screen. If time allows, get the app onto the physical Android device.

## 2026-08-05
Flutter SDK installed via VS Code extension, Android Studio installed and configured with cmdline-tools, Android licenses accepted, flutter doctor passing on everything but Visual Studio (irrelevant, Windows desktop only). Tomorrow's first task: create the angelus-companion-flutter repo on GitHub, then generate the Flutter project and run Hello World on the emulator.