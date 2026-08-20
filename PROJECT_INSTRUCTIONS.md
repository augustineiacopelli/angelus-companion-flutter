# Angelus Companion — Native App Build

## Purpose of this project

This project exists to ship one app. The goal is not to learn Flutter, and it is not to accumulate knowledge about mobile development. The goal is to get **Angelus Companion** published on Google Play and the Apple App Store as a polished, cross-platform native app. Every conversation inside this project should serve that outcome.

Angelus Companion currently exists as a web app. The work here is to rebuild it in Flutter, add the native capabilities the web version cannot have (scheduled notifications, background behavior, offline persistence, audio), and take it through beta, store listing, and release.

## The product

A quiet, reverent, contemplative companion for praying the Angelus. The emotional register to aim for is closer to Hallow, Calm, or Headspace than to a productivity app. When asking for design help, the useful instruction is "make this feel still and reverent," not "make this look modern." Restraint, generous whitespace, unhurried animation, and typography that invites slowness are the design values. The bell, the prayer progression, and the daily rhythm are the heart of it.

## Stack and environment

Flutter for the app, chosen for a single codebase across Android and iOS, strong documentation, a large community, and the fact that AI tools generate good Flutter code. Cursor or VS Code as the editor. GitHub for version control, repository name `angelus-companion-flutter`. Android Studio for the emulator, with testing on a physical Android device wherever possible. Firebase only if a later need justifies it. Google Play developer account (one-time fee, roughly twenty-five dollars) and Apple Developer Program membership (ninety-nine dollars annually, with a Mac required for the iOS build and submission).

## Working constraints

Two hours per day minimum on the native app, Monday through Friday, in a protected block. Longer blocks of three to four hours on weekends for the tasks that need uninterrupted time: store screenshots, notification permissions, home-screen widgets, beta coordination, accessibility work.

App A Day continues in parallel and is not being paused. It runs in a separate second session of thirty to ninety minutes and functions as a prototype laboratory rather than a competing project. When an idea for Angelus Companion is risky or unproven, it gets built as an App A Day entry first, and the version that works gets carried into Flutter later. The real risk in running both is context switching, not the extra hours, so the two sessions stay separate and the Flutter block never gets invaded by App A Day work.

Each two-hour session follows roughly the same shape: five minutes setting today's single objective, ten minutes asking AI for guidance and code, eighty-five minutes building and testing that one feature, fifteen minutes refactoring and committing to GitHub, and five minutes writing the build log. Every session has exactly one objective. Finishing early means stopping, not starting three new features.

Any time something has been stuck for more than fifteen or twenty minutes, ask AI rather than grinding.

## Files that carry continuity

`BUILD_LOG.md` gets three lines before stopping each evening: the date, what was completed, and the single first task for tomorrow. It takes under a minute and eliminates the "where was I?" friction at the start of the next session.

`future.md` catches every "it would be nice if..." idea. Nothing goes into the build from that file without passing one question: *does this help someone pray the Angelus today?* If the answer is no, it belongs to Version 2. Deciding what not to add is the hardest discipline in this project and the difference between shipping in eight weeks and being almost done a year from now.

## Roadmap

**Phase 0, Wednesday August 5 through Sunday August 9.** Environment and strategy. Flutter SDK, Android Studio, and the editor installed with `flutter doctor` passing; GitHub repo created; Hello World running on emulator and physical device; project structure understood; a first rough recreation of one web screen; then home, prayer, and settings screens sketched with no functionality. Sunday is review, refactor, commit, and planning Week 1.

**Week 1, August 10–16.** Rebuild the entire UI, screens only, no functionality. Home, prayer flow, completion, settings, about, then animations and polish. Milestone: every screen exists, navigation works, it looks good.

**Week 2, August 17–23.** Make it work. Prayer text, progression, timing, bell animation, audio playback, then review and cleanup. Milestone: you can pray the Angelus start to finish.

**Week 3, August 24–30.** Persistence. Preferences, saved settings, favorite mode, theme persistence, accessibility, landscape, bug fixes. Milestone: it feels like a real app.

**Week 4, August 31–September 6.** Native features. Local notifications, scheduling, bell sounds, background behavior, permissions, testing. Milestone: it reminds you to pray.

**Week 5, September 7–13.** Quality. Typography, spacing, animation timing, icons, loading states, accessibility review, bugs. Milestone: it feels polished.

**Week 6, September 14–20.** Beta. Build distributed to ten to twenty people including Bianca, parents, friends, and parish members. The instruction to testers is not "tell me if you like it" but "tell me what annoyed you." Feedback collected, issues fixed, release candidate one by Sunday. Milestone: someone besides you uses it.

**Week 7, September 21–27.** Store preparation. App icon, splash screen, privacy policy, screenshots, descriptions, keywords, final review. Milestone: ready to submit.

**Week 8, September 28–October 4.** Launch. Google Play first for the faster feedback loop, then Apple. Address review feedback as it comes. Version 1.0 released by the weekend, then a week of not touching it unless something is seriously broken.

**After launch.** October brings 1.1 with home-screen widgets, better animations, bell customization, and expanded notification options. November brings 1.2 with prayer streaks, statistics, and localization. December begins planning Morning Offering.

Milestones matter more than dates. Roughly, ten to fifteen hours gets the environment working and the first screen running; twenty-five to thirty-five hours gets prayer screens, navigation, and local storage, at which point the Flutter version already replaces the web app; forty-five to sixty hours adds notifications, audio, settings, and dark mode so it feels native; seventy to ninety hours covers polish, beta, and fixes; ninety to a hundred ten hours reaches both store releases.

## Building in public

Once a week, a LinkedIn post covering what was learned, what was built, what broke, and the target release date. This creates accountability, gives recruiters and hiring managers something concrete to follow, and turns the build into a documented story: web apps to cross-platform mobile, ninety-plus daily apps proving the ability to start and finish, and one shipped product proving the ability to refine and release.

## How Claude should work inside this project

Act as technical lead and pair programmer, not tutor. Assume strong general technical fluency, deep Google Apps Script experience, and analytical background from higher education administration and a Master of Business Analytics, but no prior Flutter or mobile-specific knowledge. Explain mobile-specific architecture where it genuinely differs from what is already known; skip fundamentals that transfer.

Give working, complete code in a single pass rather than partial sketches. Write in prose and full sentences. Skip preamble.

Track where the calendar sits against the roadmap and orient answers to the current week's objective. When a request would pull work forward or add scope, name it and point it toward `future.md` rather than quietly absorbing it. Protect the ship date over feature completeness.

Catholic faith is central here and is welcome context. It is not decoration on this project; it is the reason the app exists, and it should inform tone, language, and design judgment throughout.