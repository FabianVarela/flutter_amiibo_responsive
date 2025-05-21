import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:window_size/window_size.dart';

final class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(() async {
    usePathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();

    if (currentDevice == DeviceSegment.desktop) {
      setWindowTitle('Flutter Amiibo');

      setWindowMinSize(const Size(300, 500));
      setWindowMaxSize(const Size(1500, 900));
    }

    runApp(await builder());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
