# Khaliha 3alina — Transit Companion & Fare Splitter

A Flutter app that makes shared commutes easier. Passengers who ride together often pool cash and argue about who owes what. Khaliha 3alina works out the split automatically, and also suggests which transport options connect two transit zones.

> Published on the Amazon Appstore. <!-- TODO: add the store link -->

## The problem

Shared rides in Egypt are usually paid in cash, by several people, across several legs. Working out each person's share by hand is slow and error-prone, and knowing which route links two zones is trial and error for newcomers.

## Features

- **Fare splitting:** calculates each passenger's share when several people pool cash for the same trip.
- **Route suggestions:** recommends the available transport options between specific transit zones.
- **Offline caching:** data is stored locally with Hive so the app keeps working without a connection.
- **Firebase backend:** <!-- TODO: say what you use Firebase for, e.g. Auth / Firestore / Analytics -->

## Tech stack

| Area | Technology |
| --- | --- |
| Framework | Flutter, Dart |
| State management | Cubit (flutter_bloc) |
| Local storage | Hive |
| Backend | Firebase |
| Distribution | Amazon Appstore |

## Screenshots

<!-- TODO: add 2-3 screenshots, e.g. ![Fare split](screenshots/split.png) -->

## Getting started

Requirements: Flutter SDK installed (`flutter doctor` should pass).

```bash
git clone https://github.com/interesta22/Kaliha-3alina-App.git
cd Kaliha-3alina-App
flutter pub get
flutter run
```

This app uses Firebase. <!-- TODO: say whether firebase_options.dart / google-services.json is included, or how to add your own with `flutterfire configure` -->

## Project structure

<!-- TODO: paste the output of `tree lib -L 2` and add one line per folder -->

## How the fare split works

<!-- TODO: 3-5 lines on the rule, e.g. "total fare is divided by the number of passengers; ..." This section is the one reviewers will read most closely, so be precise. -->

## Author

Ahmed Mohamed Ahmed — [LinkedIn](https://www.linkedin.com/in/ahmedabdulaziz10) · [GitHub](https://github.com/interesta22)
