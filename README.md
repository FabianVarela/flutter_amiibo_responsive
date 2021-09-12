# Flutter · Amiibo App

![Coverage](./coverage_badge.svg?sanitize=true)

App in Flutter that connect with Amiibo API. Also set the responsive design principle.

### Getting Started

This project is available in Android, iOS, Web and Desktop

### Navigator 2.0

Actually the project has been implemented with **Navigator 2.0** or **Route API**.

#### Deep linking

For using deep links with flutter without any packages, review this [link](https://flutter.dev/docs/development/ui/navigation/deep-linking)

Run deep links in **iOS**, use the command below:
```bash
xcrun simctl openurl booted amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

Run deep links in **Android**, use the command below:
```bash
~/Library/Android/sdk/platform-tools/adb shell am start -a android.intent.action.VIEW \ -c android.intent.category.BROWSABLE \ -d amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

### Used packages

------
#### Dependencies
- Http (http)
- Flutter BLoC (flutter_bloc)
- Equatable (equatable)
- Intl (intl)
- Shimmer animation (shimmer_animation)

#### Dev dependencies
- Mocktail (mocktail)
- BLoC test (bloc_test) **Coming soon**
- Very Good Analysis (very_good_analysis)
------
