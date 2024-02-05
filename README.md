# habits_tracker

Habits Tracker is the essential tool to help you incorporate positive habits into your daily life. With an intuitive and user-friendly design, this app allows you to efficiently log and track your daily habits.
https://play.google.com/store/apps/details?id=com.benitez.amir.habitstracker

## Getting Started

If a file of the database was modified run
'dart run build_runner build'

To change the logo run
'flutter pub run flutter_launcher_icons'

To change the splash run
'dart run flutter_native_splash:create'

To use firebase debugview run
'adb shell setprop debug.firebase.analytics.app com.benitez.amir.habitstracker'
'adb shell setprop debug.firebase.analytics.app .none.'

If app localization is not detected
flutter packages pub run build_runner build --delete-conflicting-outputs
