# Geo Olly

Geo Olly location app.

This is a Flutter app that follows the Vanilla software development philosophy, so that it has the following advantages (similar to the ones obtained by using VanillaJS in web development):

- No external dependencies required besides the ones specified in pubspec.yaml, reducing complexity.

- No special IDE required. Reducing set up steps to almost 0.

- 0 Visual Studio Code plugins required. So, no possibility of being victim of common malware present in plugins. Source: Malicious VSCode extensions with millions of installs discovered
https://www.bleepingcomputer.com/news/security/malicious-vscode-extensions-with-millions-of-installs-discovered

- No third-party state management, only the Flutter standard library, thus performance is literally the best Flutter can possibly offer.

- Reduce to almost zero the possibility of having issues related to dependencies versions conflicts. Which tend to raise to the sky the costs of maintenance.


## Set up instructions

1. Open this directory in the terminal
2. Launch an Android emulator (usually with a command like this: flutter emulators --launch <my-emulator-name>) or connect an Android phone to the laptop (with "USB debugging" option enabled in "Settings/Developer options" of the phone).
3. Execute in terminal: flutter run


## Build APK

Execute these commands in Windows terminal in the project root directory:

- flutter build apk
- rem Just to open the directory faster than manually:
- cd build\app\outputs\apk\release
- explorer .


## Data persistance in the app

This app uses Hive as a local database for data persistance.
https://pub.dev/packages/hive

According to multiple benchmarks, Hive is better than popular options like SharedPreferences or SQLite. Source:
https://github.com/hivedb/hive_benchmark


## Hive data

Hive stores data in boxes, and each box consists of key-value pairs.

The "users" box contains users identified by their user ID. The key is the user ID and the value is a Map object. And the map's field are:

{
  email: String.
  password: String.
  weathers: List<Map>. The list of saved weathers.
}