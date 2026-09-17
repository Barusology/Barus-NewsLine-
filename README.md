# Barus NewsLine

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![NewsAPI](https://img.shields.io/badge/News-API-FF6B6B?style=for-the-badge)
![Material%203](https://img.shields.io/badge/Design-Material%203-5C6BC0?style=for-the-badge)

</div>

Barus NewsLine is a modern Flutter news app built for fast, readable access to daily headlines and breaking stories. It brings together a clean top-news experience, article search, bookmark management, and social sharing in a single mobile-first interface.

## Overview

The app is designed for readers who want a lightweight way to stay informed without friction. It fetches live headlines from the NewsAPI service, surfaces top stories and breaking news in visually distinct cards and carousels, and keeps the experience focused on speed, clarity, and usability.

## Core Features

- Top headlines feed for the latest U.S. news
- Breaking news carousel for featured stories
- Search-based article discovery
- Bookmark and recall saved stories locally
- Share articles with other apps
- Pull-to-refresh and re-fetch updates on demand
- Open article links in the browser for full reading
- Clean Material 3 interface suitable for continued product growth

## App Experience

- Home dashboard with a modern news layout
- Search flow for targeted topic discovery
- Saved articles list on the bookmark tab
- Refresh controls to re-fetch the latest content
- Responsive mobile UX for Android and iOS

## Tech Stack

- Flutter
- Dart
- NewsAPI
- HTTP client
- SharedPreferences for local bookmark persistence
- SharePlus for article sharing
- URL Launcher for article links
- Carousel Slider for featured stories
- Cached Network Image for efficient media loading

## Project Structure

```text
.
├── android/                 # Android project configuration
├── ios/                     # iOS project configuration
├── lib/
│   ├── models/              # Data models such as Article and Source
│   ├── screens/             # Home, bookmark, and app navigation screens
│   ├── services/            # News API and persistence services
│   ├── widgets/             # Reusable UI components like news cards and sliders
│   ├── main.dart            # App entry point
│   └── ...
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Flutter app dependencies and metadata
├── .env.example             # Sample API key configuration
├── README.md                # Project documentation
├── analysis_options.yaml    # Lint configuration
├── .gitignore
└── ...
```

## Getting Started

### Prerequisites

Before running the app, make sure you have the following installed:

- Flutter SDK (3.x or newer)
- Dart SDK
- Android Studio or VS Code with Flutter tooling
- A NewsAPI key
- An emulator or connected physical device

### 1. Clone the repository

```bash
git clone https://github.com/Barusology/Barus-NewsLine-.git
cd Barus-NewsLine-
```

### 2. Configure the News API key

Copy the sample environment file and add your key:

```bash
cp .env.example .env
```

Then update the value in `.env` or pass it during runtime:

```bash
flutter run --dart-define=NEWS_API_KEY=your_newsapi_key
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

## Build Commands

### Android

```bash
flutter build apk
```

### iOS

```bash
flutter build ios
```

### Web

```bash
flutter build web
```

## Development Notes

This project uses a `NEWS_API_KEY` defined at build time through `--dart-define`. The app is structured to keep data-fetching logic in the service layer and UI concerns separated in the screen and widget layers.

## Security Note

Do not commit production API keys or sensitive credentials to source control. Use environment variables or secure local configuration when deploying beyond development use.

## Contributing

Contributions are welcome. If you want to improve Barus NewsLine, please fork the repository and submit a pull request with a clear description of the changes.

## License

This project is intended for development and further iteration. Please review licensing and third-party API terms before commercial or public deployment.

## Repository

- GitHub: https://github.com/Barusology/Barus-NewsLine-
