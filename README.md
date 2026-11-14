# Flutter Amiibo App

![Coverage](./coverage_badge.svg?sanitize=true)

Flutter application to explore the world of Nintendo Amiibo figures using the Amiibo API. Built with BLoC pattern for
state management, responsive design for all screen sizes, and Navigator 2.0 for advanced navigation with deep linking
support.

## Prerequisites

Before getting started, make sure you have the following installed:

- **Flutter SDK**: >=3.10.0 <4.0.0
- **Dart SDK**: >=3.10.0 <4.0.0
- **IDE**: VSCode or Android Studio with Flutter extensions
- **Platforms**:
    - For iOS: Xcode (macOS only)
    - For Android: Android Studio or Android SDK
    - For macOS: Xcode
    - For Web: Google Chrome
    - For Windows: Visual Studio 2019 or later

## Initial Setup

### 1. Clone the repository

```bash
git clone <repository-url>
cd flutter_amiibo_responsive
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate code

This project uses code generation for JSON serialization:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Development

### Run the application

```bash
flutter run
```

### Run on specific platform

```bash
# iOS
flutter run -d iPhone

# Android
flutter run -d android

# macOS
flutter run -d macOS

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

### Build for production

```bash
# iOS
flutter build ios

# Android (App Bundle)
flutter build appbundle

# Android (APK)
flutter build apk

# macOS
flutter build macos

# Web
flutter build web

# Windows
flutter build windows
```

## Project Structure

```
lib/
├── bloc/                    # BLoC state management
│   ├── amiibo_bloc/        # Amiibo list BLoC
│   └── amiibo_detail_bloc/ # Amiibo detail BLoC
├── data/                   # Data layer
│   ├── models/            # Data models (JSON serializable)
│   └── repository/        # Data repositories
├── router/                 # Navigator 2.0 implementation
│   ├── router_delegate.dart
│   ├── route_information_parser.dart
│   └── routes.dart
├── ui/                     # UI layer
│   ├── pages/             # Application pages
│   └── widgets/           # Reusable widgets
└── utils/                  # Utilities and helpers
    ├── constants/         # App constants
    └── responsive/        # Responsive design utilities
assets/
├── images/                 # Image assets
└── fonts/                  # Custom fonts (Nunito)
```

## Features

### Amiibo Browsing

- **Grid View**: Browse Amiibo figures in a responsive grid layout
- **List View**: Alternative list view for browsing
- **Categories**: Filter Amiibo by game series
- **Search**: Search Amiibo by name
- **Sorting**: Sort by name, release date, or series

### Amiibo Details

- **Detailed Information**: View complete Amiibo information
    - Character name and series
    - Game series
    - Release dates by region
    - Amiibo type
    - High-quality images
- **Related Amiibos**: See related figures from the same series
- **Deep Linking**: Direct navigation to specific Amiibo

### Responsive Design

- **Adaptive Layouts**: Optimized for all screen sizes
    - Mobile: Single column layout
    - Tablet: 2-3 column grid
    - Desktop: 4-6 column grid
- **Breakpoints**: Custom responsive breakpoints
- **Orientation Support**: Portrait and landscape modes
- **Platform-Specific UI**: Native look and feel on each platform

### Navigator 2.0

- **Custom Implementation**: Advanced navigation with Navigator 2.0
- **Deep Linking**: URL-based navigation support
- **State Restoration**: Navigation state persists across app restarts
- **Browser Integration**: Full web browser back/forward support

### UI/UX Features

- **Shimmer Loading**: Elegant skeleton loading states
- **Smooth Animations**: Polished transitions and interactions
- **Error Handling**: User-friendly error messages
- **Pull to Refresh**: Refresh Amiibo list
- **Infinite Scroll**: Load more Amiibo as you scroll
- **Image Caching**: Fast image loading with caching

## API Documentation

This project uses the Amiibo API:

- **API Endpoint**: `https://www.amiiboapi.com/api/`
- **API Documentation**: [Amiibo API Docs](https://www.amiiboapi.com/)

### Main Endpoints

#### Get all Amiibos

```
GET /api/amiibo/
```

Returns a list of all Amiibo figures.

#### Get Amiibo by ID

```
GET /api/amiibo/?id={amiibo_id}
```

Returns details for a specific Amiibo.

#### Filter by Game Series

```
GET /api/amiibo/?gameseries={series_name}
```

Returns Amiibos from a specific game series.

#### Filter by Amiibo Series

```
GET /api/amiibo/?amiiboSeries={series_name}
```

Returns Amiibos from a specific Amiibo series.

### Response Format

```json
{
  "amiibo": [
    {
      "amiiboSeries": "Super Smash Bros.",
      "character": "Mario",
      "gameSeries": "Super Mario",
      "head": "00000000",
      "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png",
      "name": "Mario",
      "release": {
        "au": "2014-11-29",
        "eu": "2014-11-28",
        "jp": "2014-12-06",
        "na": "2014-11-21"
      },
      "tail": "00000002",
      "type": "Figure"
    }
  ]
}
```

## Deep Linking

The app supports deep linking for direct navigation to specific Amiibos.

### URL Format

```
amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}

# Using HTTPS
https://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

### Testing Deep Links

**iOS Simulator**:

```bash
xcrun simctl openurl booted amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}

# Using HTTPS
xcrun simctl openurl booted "https://amiiboexample.com/amiibos/{type}/amiibo/{id}"
```

**Android Emulator/Device**:

```bash
adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}

# Using HTTPS
adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d "https://amiiboexample.com/amiibos/{type}/amiibo/{id}" \
  <your_package_id>
```

**macOS and Windows**

```
amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}

# Using HTTPS
https://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

Replace `{type}` and `{id}` with actual Amiibo type and ID from the API.

### Configuring Deep Links

- For detailed information on deep linking setup,
  see [Flutter Deep Linking Guide](https://flutter.dev/docs/development/ui/navigation/deep-linking).
- For **iOS** (maybe **macOS**) using *app_links*, you must associate the domain in Xcode in the "Signing
  and Capabilities" section and add the "Associated Domains" capability. However, you must have and add an
  ***Apple Developer*** account.

## Testing

### Run all tests

```bash
flutter test
```

### Run tests with coverage

The project includes scripts for running tests with coverage reporting:

#### macOS/Linux

First, install lcov:

```bash
# macOS (with Homebrew)
brew install lcov

# Linux
sudo apt -y install lcov
```

Run the coverage script:

```bash
bash test_coverage.sh
```

#### Windows

First, install lcov via Chocolatey:

```powershell
choco install lcov
```

If you get execution policy errors, run PowerShell as Administrator:

```powershell
Set-ExecutionPolicy RemoteSigned
```

Run the coverage script:

```powershell
.\test_coverage.ps1
```

### View coverage report

After running the coverage script, open `coverage/index.html` in your browser to view the detailed coverage report.

### Run specific test file

```bash
flutter test test/path/to/test_file.dart
```

### Integration Testing

To run integration tests on mobile and web:

```bash
# iOS
flutter test integration_test/app_test.dart -d iPhone

# Android
flutter test integration_test/app_test.dart -d android

# Web
flutter test integration_test/app_test.dart -d chrome
```

For more information,
see [Flutter Integration Testing Guide](https://docs.flutter.dev/cookbook/testing/integration/introduction).

## Code Quality

### Run code analysis

The project uses `very_good_analysis` to maintain code quality:

```bash
flutter analyze
```

### Format code

```bash
flutter format .
```

### Generate code

For JSON serialization:

```bash
# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and auto-generate
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Main Dependencies

### State Management & Architecture

- **flutter_bloc**: BLoC pattern implementation
- **equatable**: Value equality for BLoC states
- **flutter_hooks**: React-like hooks for Flutter

### Networking & Data

- **http**: HTTP client for API calls
- **json_annotation**: JSON serialization annotations
- **json_serializable**: JSON serialization code generation

### UI Components

- **google_fonts**: Google Fonts integration
- **shimmer_animation**: Skeleton loading states
- **gap**: Spacing widgets

### Utilities

- **intl**: Date formatting and internationalization
- **collection**: Enhanced collection utilities
- **window_size**: Desktop window management

### Dev Dependencies

- **build_runner**: Code generation
- **bloc_test**: Testing utilities for BLoC
- **mocktail**: Mocking library for tests
- **mocktail_image_network**: Mock network images for tests
- **flutter_launcher_icons**: App icon generation
- **flutter_native_splash**: Splash screen generation
- **remove_from_coverage**: Exclude generated files from coverage
- **very_good_analysis**: Strict lint rules
- **integration_test**: Integration testing support

## Responsive Design

### Breakpoints

The app uses custom breakpoints for responsive layouts:

- **Mobile**: < 600px
- **Tablet**: 600px - 1024px
- **Desktop**: > 1024px

### Adaptive Grid

The Amiibo grid adapts based on screen size:

- **Mobile**: 2 columns
- **Tablet Portrait**: 3 columns
- **Tablet Landscape**: 4 columns
- **Desktop**: 4-6 columns (based on width)

### Platform-Specific Features

#### Desktop (Windows, macOS)

- Resizable windows with minimum size constraints
- Native window controls
- Keyboard shortcuts
- Mouse hover effects

#### Mobile (iOS, Android)

- Pull-to-refresh gestures
- Platform-specific navigation
- Native scroll physics
- Touch-optimized tap targets

#### Web

- Responsive breakpoints
- Browser back/forward support
- URL-based routing
- Touch and mouse support
- Optimized image loading

## Troubleshooting

### Error: "Flutter SDK not found"

Verify that Flutter is installed correctly and in your PATH:

```bash
flutter doctor
```

### API connection errors

- Check your internet connection
- Verify the Amiibo API is accessible at `https://www.amiiboapi.com/`
- Check API status and rate limits

### Code generation fails

Clean and regenerate:

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Images not loading

- Verify internet connection for remote images
- Check image URLs are valid
- Clear app cache and restart

### Deep linking not working on iOS/macOS

- Verify URL schemes in `Info.plist`
- Check Associated Domains entitlement
- Ensure proper signing configuration

### Deep linking not working on Android

- Verify intent filters in `AndroidManifest.xml`
- Check app links configuration
- Test with proper URL format

### macOS build fails

```bash
flutter clean
cd macos
pod install
cd ..
flutter build macos
```

### Windows build fails

- Ensure Visual Studio 2019+ is installed
- Install Windows SDK
- Run as Administrator if needed

### Web CORS errors

The Amiibo API should support CORS, but if you encounter issues:

- Run with `--web-renderer html` flag
- Check browser console for specific CORS errors
- Verify API endpoint supports cross-origin requests

### Tests not finding coverage script

Ensure the script has execution permissions:

```bash
chmod +x test_coverage.sh
```

### BLoC state not updating

- Check if events are being added to the bloc
- Verify state equality with Equatable
- Use BlocObserver for debugging
- Check for proper bloc disposal

## Performance Optimization

This app implements several performance optimizations:

### Network Optimization

- **HTTP Caching**: Cache API responses to reduce network calls
- **Image Caching**: Cache images for faster loading
- **Lazy Loading**: Load images on demand
- **Debouncing**: Prevent excessive API calls during search

### UI Optimization

- **Efficient State Management**: BLoC prevents unnecessary rebuilds
- **Const Constructors**: Reduced widget rebuilds
- **RepaintBoundary**: Isolate expensive widgets
- **Shimmer Loading**: Better perceived performance

### Memory Management

- **Image Optimization**: Properly sized images for different screens
- **List Recycling**: Efficient scrolling with ListView.builder
- **Dispose Resources**: Proper cleanup of controllers and streams

## Architecture

### BLoC Pattern

The app follows the BLoC (Business Logic Component) pattern:

- **UI**: Widgets that display data and emit events
- **BLoC**: Business logic that processes events and emits states
- **Repository**: Data layer that communicates with the API
- **Models**: Data classes with JSON serialization

### Data Flow

1. User interacts with UI (tap, scroll, search)
2. UI emits event to BLoC
3. BLoC processes event and calls repository
4. Repository fetches data from Amiibo API
5. Repository returns data to BLoC
6. BLoC transforms data and emits new state
7. UI rebuilds based on new state

### Navigator 2.0 Implementation

Custom Navigator 2.0 implementation featuring:

- **RouterDelegate**: Manages app navigation state
- **RouteInformationParser**: Parses URLs to navigation state
- **Route Configuration**: Type-safe route definitions
- **Deep Linking**: URL-based navigation support
- **State Restoration**: Navigation persists across restarts

## Contributing

1. Create a branch from `main`
2. Make your changes
3. Run tests: `flutter test`
4. Run analysis: `flutter analyze`
5. Format code: `flutter format .`
6. Generate code if needed: `flutter pub run build_runner build --delete-conflicting-outputs`
7. Create a Pull Request to `main`

## Testing Strategy

### Unit Tests

- BLoC event/state testing with bloc_test
- Repository method testing
- Model serialization testing
- Business logic validation

### Widget Tests

- Widget rendering tests
- User interaction tests
- State change verification
- Navigation testing

### Integration Tests

- End-to-end user flows
- API integration testing
- Navigation flow testing
- Platform-specific features

## License

[Include license information here]
