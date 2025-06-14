# Task Manager App

A simple task management Flutter application integrated with Firebase. Users can add, update, and
delete their personal tasks, with all data stored in Firestore. The app ensures user-specific task
visibility using Firebase Authentication.

---

## Features

- User authentication with Firebase (Email & Password)
- Save token locally using Hive
- Sign up, log in, log out functionality
- ‍️ Auto-login with token refresh logic on app start
- Splash screen to check auth state
- Create, update, delete tasks
- Real-time sync with Firestore
- Per-user task visibility
- Built with Flutter + GetX

Token Management

Hive is used for lightweight secure local storage.
On login, Firebase token is saved in Hive.
On app start, splash screen checks for valid token and routes accordingly.
If token is expired, it is force-refreshed using user.getIdToken(true).

## Unit Tests

Basic unit tests have been added to ensure the core functionality of the app remains stable. These
tests cover:

- Task creation and validation
- Task update logic
- Task deletion
- Edge case handling for empty fields

To run the tests:
flutter test


---

## Getting Started

Follow these instructions to set up and run the app on your local machine.

### 1. Clone the Repository

```bash
git clone https://github.com/swaroopkgeddannavar/MilesEducation.git
cd task-manager
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Firebase

- Create a Firebase project: https://console.firebase.google.com
- Add Android/iOS app to the project
- Download `google-services.json` (Android)
- Place files in:
    - `android/app/google-services.json`
    - `ios/Runner/GoogleService-Info.plist`
- Enable Firebase Authentication (Email/Password)
- Enable Firestore Database
- Create a collection named `tasks`

### 4. Run the App

```bash
flutter run
```

---

## Notes

- Make sure Firebase is properly configured in your app

