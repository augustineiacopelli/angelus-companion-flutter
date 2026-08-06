# Angelus Companion — Build Log

## 2026-08-06
Created angelus-companion-flutter repo and cloned to ~/dev. Generated Flutter project with org com.augustineiacopelli, bundle id com.augustineiacopelli.angelus_companion. Resolved missing JAVA_HOME for sdkmanager (Android Studio JBR at "C:\Program Files\Android\Android Studio\jbr", now set permanently) and installed the android-35 google_apis_playstore x86_64 system image, which Android Studio had skipped. Created and launched the angelus_pixel emulator. Hello World counter app built and running on emulator, hot reload confirmed at 698ms. Initial scaffold committed and pushed. Physical device testing still outstanding from Phase 0.
Tomorrow: walk the generated project structure — lib, pubspec.yaml, the android and ios folders, what main.dart is actually doing — then begin a rough recreation of one Angelus Companion web screen. If time allows, get the app onto the physical Android device.

## 2026-08-05
Flutter SDK installed via VS Code extension, Android Studio installed and configured with cmdline-tools, Android licenses accepted, flutter doctor passing on everything but Visual Studio (irrelevant, Windows desktop only). Tomorrow's first task: create the angelus-companion-flutter repo on GitHub, then generate the Flutter project and run Hello World on the emulator.