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

# Using https
xcrun simctl openurl booted "https://amiiboexample.com/amiibos/{type}/amiibo/{id}"
```

Run deep links in **Android**, use the command below:

```bash
~/Library/Android/sdk/platform-tools/adb shell am start -a android.intent.action.VIEW \ -c android.intent.category.BROWSABLE \ -d amiiboapp://amiiboexample.com/amiibos/{type}/amiibo/{id}

#Using https
~/Library/Android/sdk/platform-tools/adb shell am start -a android.intent.action.VIEW \ -c android.intent.category.BROWSABLE \ -d "https://amiiboexample.com/amiibos/{type}/amiibo/{id}" \ <your_package_id>
```

### Unit testing and coverage

To execute the unit testing and show the coverage, you must run the `test_coverage` file by console.

#### Mac and Linux

Before to run the script, you must have installed the `lcov` package.

For macOS, via `brew` (you must have the home brew already installed).

```bash
brew install lcov
```

For Linux use the command below.

```bash
sudo apt -y install lcov
```

After, you must run the `test_coverage.sh`.

```bash
bash test_coverage.sh
```

#### Windows

Before to run the script, you must have installed the `lcov` package via `chocolatey` (you must have the chocolatey
already installed).

```powershell
choco install lcov
```

After, you must run the `test_coverage.ps1`. If running the `ps1` file you have an error, you must run as administrator
the `PowerShell` and type the command below.

```powershell
Set-ExecutionPolicy RemoteSigned
```

And finally, run the `ps1` script.

```powershell
.\test_coverage.ps1
```

### Integration testing

If you want to execute integration testing in mobile and web, follow
this [link](https://docs.flutter.dev/cookbook/testing/integration/introduction#5-run-the-integration-test)
