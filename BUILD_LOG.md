# Angelus Companion — Build Log

## 2026-08-12
Extracted the completion from `prayer_screen.dart` into
`lib/screens/completion_screen.dart` as a real destination. Removed the
duplicated Amen, closed the versicle with its response, and replaced the
joined progress rule with a single gold line. The screen takes an
`onReturn` callback so the pushing screen owns the navigation stack.
Initially pushed the completion on top of the prayer so a stray tap during
the collect could be undone with the back gesture. On the emulator, a
single back press from the completion cleared both routes and landed on
home rather than returning to the collect. No code path in
`prayer_screen.dart`, `fade_route.dart`, or `main.dart` accounts for the
second pop, and diagnosing further requires a debug connection that was
unavailable. Switched to `pushReplacement`, so RETURN and the back gesture
both end on home. The `_finishing` guard stays and no longer clears, which
is correct now that the prayer route is disposed at the transition.
The VM service would not attach all session. DDS shut down immediately on
8181/8182 and again on pinned alternates 8183/8184. Ports were free, no
orphaned dart processes, adb cleared. Verified the whole day in release
mode instead, which needs no VM service.
Tomorrow: animation timing across the flow, starting with the mismatch
between the 650ms `fadeRoute` and the 700ms `AnimatedSwitcher`.

## 2026-08-11
Week 1 Day 2. Built the two remaining dead settings rows, so nothing in the
app taps to nothing. Added lib/models/settings_options.dart holding BellVoice
and PrayerTextSize as enhanced enums, each constant carrying its own display
copy and, for text size, its scale multiplier, so the values travel with the
type rather than living in a switch elsewhere. Added lib/widgets/choice_page.dart
with ChoicePage and ChoiceOption, built on QuietPage the way About and Privacy
are, since bell and text size are the same shape and theme selection in Week 3
will be a third. Selection is marked with a gold check that cross-fades between
rows rather than a Material radio, which would be louder than anything else on
screen, and each row carries Semantics with selected set for TalkBack.
Built bell_screen.dart with four voices and text_size_screen.dart with four
sizes and a live preview.
Architecture decision worth keeping. The picker holds its own selection and
reports every change upward immediately rather than returning a value through
Navigator.pop. A pushed route does not rebuild when the screen that pushed it
calls setState, so passing the value down would have frozen the checkmark. More
importantly, popping with a result covers only the back arrow and returns null
for the hardware button and the edge gesture, which have no web equivalent and
no obvious failure mode. Reporting upward makes all three paths identical.
The preview pulls its text from angelus.first and multiplies the font sizes the
theme already declares rather than literals, so Week 2 writes the same
expression on the prayer screen and a later type change moves both. It sits at
the bottom because it grows at Largest and anything below the options would
shift under a finger mid-choice.
Two things deliberately not done. The bell picker has no audition control until
audio lands in Week 2; a play button that plays nothing is worse than none. And
the chosen text size does not yet reach the prayer screen, because settings
owns this state locally and prayer is pushed from home, so applying it means an
app-level holder. That holder is exactly what Week 3 builds when these values
start persisting, and building it twice is the wrong trade.
Correction to the port theory carried since 2026-08-07. Endpoint security on
this machine does not block ephemeral high ports. Today the VM service came up
on 52346 and connected cleanly under --no-dds. Every failure this week has been
DDS. netstat on 8181 was clean before launch and adb forward --list was empty
both before and during the failure, so there was no collision and no stale
forward; there was simply no bridge. Pinned ports did take effect this run, the
orphaned process showing --vm-service-uri on 8181 and --bind-port=8182, and DDS
still failed to reach the app, refusing on 64329. Sunday's --bind-port=0 process
was a symptom of DDS dying rather than the cause. Running with --no-dds costs
DevTools only; hot reload, hot restart, and the console all work, which is an
acceptable trade through Week 5 when animation timing will want DevTools back.
Back navigation verified by arrow and by the emulator's on-screen back control.
The edge-swipe gesture was not testable because this emulator image is set to
three-button navigation, which folds into the physical device work in Week 4
alongside Doze and exact alarm permissions.
Tomorrow, first task: the completion screen. Prayer currently ends in an inline
_Completion inside prayer_screen.dart, and Week 1 calls for it as its own screen
before animation and polish take the back half of the week.
Scope note on the above. The clean high-port connection was observed at the
office. Sunday's failing session was at home, likely on VPN. DDS failed in both
places, so that conclusion holds, but whether ephemeral ports are actually open
is confirmed for the office network only. Test --no-dds at home before treating
the firewall as ruled out generally.

## 2026-08-10
Week 1 Day 1. Closed the informational screens and made the settings
navigation real. Added lib/widgets/quiet_page.dart holding QuietPage plus the
Prose, Coda, and PageLabel primitives, since About and Privacy share one shape
and reading text needs different treatment from prayer text. Reading prose is
ivory rather than the muted bodyMedium default, because muted at 17px sits near
4.5:1 against night, which is fine for a two-line versicle and tiring across
four paragraphs. Built about_screen.dart and privacy_screen.dart on top of it.
Rewrote _NavRow in settings_screen.dart to take an optional onTap, wrapped the
row in an opaque GestureDetector so the whole row is the target, and made the
chevron conditional on onTap so the Version row stops implying it navigates.
About and Privacy are now reachable through fadeRoute. flutter analyze clean,
navigation verified on the emulator.
Deliberate copy decision: About describes only what the app already does. No
mention of the Regina Caeli replacing the Angelus during Eastertide, which
belongs in future.md rather than on a screen a beta tester will read.
Privacy copy is written now rather than in Week 7 because every sentence in it
is a constraint on the persistence and notification work in Weeks 3 and 4.
Created future.md, which the plan assumed existed and the repo did not have.
Correction to the 2026-08-09 entry. The pinned-port fix is more fragile than
recorded. Today's DevFS failure looked identical to Saturday's but had a
different cause: adb forward --list was empty and nothing was LISTENING on
8181, but two TIME_WAIT sockets on 8181 remained from Sunday's session.
Windows holds TIME_WAIT for up to four minutes and refuses a rebind during it,
and Flutter does not fail loudly when it cannot bind the requested port. It
falls back to an ephemeral port silently. The orphaned DDS process showed
--vm-service-uri=http://127.0.0.1:61641/ with --bind-port=0, meaning neither
pinned port took effect and the connection landed in exactly the high range
this machine blocks. Fix was killing the orphaned dart.exe DDS and flutter_tools
processes, leaving the language server, tooling daemon, and DevTools alone,
then relaunching on 8183 and 8184. New rule: after a run dies, check
netstat -ano | Select-String "8181" before relaunching. If anything comes back
at all, including TIME_WAIT, launch on 8183/8184 rather than letting Flutter
fall back without saying so.
Two dependencies logged. A physical Android device is a Week 4 prerequisite,
not a Week 6 one, since Doze, exact alarm permissions, and manufacturer battery
optimization do not reproduce on the emulator; ordering this week. And Play
requires a publicly reachable privacy policy URL, which the in-app screen does
not satisfy; GitHub Pages on the existing public repo is the Week 7 answer.
Tomorrow, first task: build the bell picker and text size picker, the last two
dead _NavRow entries in settings, so nothing in the app taps to nothing.

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