# Z-Taksi 🚖

Commission-free taxi hailing app built with Flutter to support local drivers.

## Overview

Z-Taksi is a modern, Uber-like ride-hailing application that connects passengers with drivers without charging commission fees. The app is built with Flutter and provides a seamless experience for both passengers and drivers.

## Features

### For Passengers 👤
- **Easy Registration**: Quick sign-up with email and phone verification
- **Real-time Location**: Automatic location detection using GPS
- **Ride Booking**: Simple interface to book rides with fare estimation
- **Live Tracking**: Track your driver in real-time (with Google Maps integration)
- **Ride History**: View all past rides with detailed information
- **Transparent Pricing**: See fare breakdown before booking

### For Drivers 🚗
- **Driver Mode**: Toggle online/offline status
- **Ride Requests**: Accept ride requests from nearby passengers
- **Navigation**: Integrated maps for easy navigation
- **Earnings**: No commission - drivers keep 100% of the fare
- **Ride Management**: Track current rides and update status

## Technology Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Maps**: Google Maps Flutter
- **Location**: Geolocator & Geocoding
- **Authentication**: Firebase Auth (optional)
- **Database**: Cloud Firestore (optional)
- **UI**: Material Design 3

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart
│   ├── driver_model.dart
│   └── ride_model.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── location_provider.dart
│   └── ride_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   ├── home/
│   ├── ride/
│   └── profile/
├── services/                 # Business logic
│   ├── auth_service.dart
│   ├── location_service.dart
│   └── ride_service.dart
├── utils/                    # Utilities
│   ├── constants.dart
│   └── theme.dart
└── widgets/                  # Reusable widgets
    └── custom_button.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode
- Google Maps API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/arrrrny/z-taksi.git
   cd z-taksi
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Maps API**
   
   - Get your API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Enable Google Maps SDK for Android and iOS
   
   **Android**: Update `android/app/src/main/AndroidManifest.xml`
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_API_KEY_HERE"/>
   ```
   
   **iOS**: Update `ios/Runner/AppDelegate.swift`
   ```swift
   GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Configuration

### Firebase Setup (Optional)

To enable real-time features and authentication:

1. Create a Firebase project
2. Add Android and iOS apps to your Firebase project
3. Download and add configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
4. Uncomment Firebase initialization in `lib/main.dart`

### Environment Variables

Update the following constants in `lib/utils/constants.dart`:

```dart
static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
static const double baseFarePrice = 2.50;        // Base fare
static const double pricePerKm = 1.50;           // Price per kilometer
static const double pricePerMinute = 0.30;       // Price per minute
```

## App Screens

1. **Splash Screen**: Initial loading screen
2. **Login/Signup**: User authentication
3. **Home Screen**: 
   - Passenger view: Map with booking options
   - Driver view: Ride requests and status
4. **Ride Booking**: Enter pickup and destination
5. **Ride History**: Past rides with details
6. **Profile**: User information and settings

## User Roles

- **Passenger**: Can book rides, view history, and manage profile
- **Driver**: Can accept rides, navigate to pickup/destination, and track earnings

## Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Permissions

The app requires the following permissions:

- **Location**: For finding nearby drivers and navigation
- **Internet**: For real-time updates and map data

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

For support and questions, please open an issue in the GitHub repository.

## Roadmap

- [ ] Real-time driver tracking
- [ ] In-app payments integration
- [ ] Push notifications
- [ ] Rating and review system
- [ ] Multi-language support
- [ ] Dark mode
- [ ] Ride scheduling
- [ ] Split fare feature
- [ ] Driver verification system

## Screenshots

(Add screenshots of your app here once built)

---

Made with ❤️ for local drivers and communities
