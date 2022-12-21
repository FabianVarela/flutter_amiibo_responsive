# Flutter · Amiibo App

![Coverage](./coverage_badge.svg?sanitize=true)

App made with Flutter that connect with Amiibo API and show different figures. This app uses http to connect with API
and bloc as state management. Also, this app uses the responsive design principle to show in different devices.

## Getting Started

This project is available in Android, iOS, Web and Desktop (Windows and MacOS).

### Navigator 2.0

Actually the project has been implemented with **Navigator 2.0** or **Route API**.

#### Deep linking

For using deep links with flutter without any packages, review
this [link](https://flutter.dev/docs/development/ui/navigation/deep-linking)

Run deep links in **iOS**, use the command below:

```bash
xcrun simctl openurl booted amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

Run deep links in **Android**, use the command below:

```bash
~/Library/Android/sdk/platform-tools/adb shell am start -a android.intent.action.VIEW \ -c android.intent.category.BROWSABLE \ -d amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}
```

### Integration testing

To execute integration testing in mobile and web, follow
this [link](https://docs.flutter.dev/cookbook/testing/integration/introduction#5-run-the-integration-test)

### Used packages

------

#### Dependencies

- Collection ([collection](https://pub.dev/packages/collection))
- Equatable ([equatable](https://pub.dev/packages/equatable))
- Flutter bloc ([flutter_bloc](https://pub.dev/packages/flutter_bloc))
- Freezed annotation ([freezed_annotation](https://pub.dev/packages/freezed_annotation))
- Google fonts ([google_fonts](https://pub.dev/packages/google_fonts))
- Http ([http](https://pub.dev/packages/http))
- Intl ([intl](https://pub.dev/packages/intl))
- Json annotation ([json_annotation](https://pub.dev/packages/json_annotation))
- Shimmer animation ([shimmer_animation](https://pub.dev/packages/shimmer_animation))
- Window size ([window_size](https://pub.dev/packages/window_size))

#### Dev dependencies

- Bloc test ([bloc_test](https://pub.dev/packages/bloc_test))
- Build runner ([build_runner](https://pub.dev/packages/build_runner))
- Freezed ([freezed](https://pub.dev/packages/freezed))
- Mocktail ([mocktail](https://pub.dev/packages/mocktail))
- Network image mock ([network_image_mock](https://pub.dev/packages/network_image_mock))
- Remove from coverage ([remove_from_coverage](https://pub.dev/packages/remove_from_coverage))
- Very good analysis ([very_good_analysis](https://pub.dev/packages/very_good_analysis))

------
