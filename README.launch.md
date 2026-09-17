# Barus NewsLine

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![NewsAPI](https://img.shields.io/badge/News-API-FF6B6B?style=for-the-badge)

</div>

Barus NewsLine is a fast, mobile-first news app for readers who want a clean and modern way to discover headlines, trending stories, and saved articles in one place.

## Why it exists

The app gives users a streamlined experience for staying informed without clutter. It combines live news feeds, search, breaking-story highlights, and personal bookmarks in a simple Flutter interface.

## Key features

- Top headlines feed
- Breaking news carousel
- Search articles by topic
- Save and revisit favorite stories
- Share articles to other apps
- Pull-to-refresh and live updates
- Lightweight, user-friendly mobile UX

## Tech stack

- Flutter
- Dart
- NewsAPI
- SharedPreferences
- HTTP
- SharePlus
- URL Launcher

## Quick start

### Prerequisites

- Flutter SDK 3.x+
- Dart SDK
- NewsAPI key
- Android Studio or VS Code

### Install

```bash
git clone https://github.com/Barusology/Barus-NewsLine-.git
cd Barus-NewsLine-
flutter pub get
```

### Run

```bash
flutter run --dart-define=NEWS_API_KEY=your_newsapi_key
```

### Build

```bash
flutter build apk
flutter build ios
flutter build web
```

## Project structure

```text
.
├── lib/
├── android/
├── ios/
├── test/
├── pubspec.yaml
├── .env.example
├── README.md
└── README.launch.md
```

## Security note

Keep your NewsAPI key in local environment configuration and do not commit it to version control.

## Repository

https://github.com/Barusology/Barus-NewsLine-
