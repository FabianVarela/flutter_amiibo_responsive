import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _routerDelegate = AmiiboRouterDelegate();
  final _informationParser = AmiiboInfoParser();

  final _appLinks = AppLinks();
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => Client()),
        RepositoryProvider(
          create: (context) => AmiiboClient(context.read<Client>()),
        ),
        RepositoryProvider(
          create: (context) => AmiiboRepository(context.read<AmiiboClient>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Amiibo App',
        theme: AmiiboTheme.setThemeData(
          context,
          ColorScheme.fromSeed(
            seedColor: const Color(0xFFE6001E),
            brightness: Brightness.dark,
          ),
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: _informationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }

  Future<void> _initDeepLinks() async {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _routerDelegate.parseRoute,
      onError: (Object error) {
        if (kDebugMode) print('Uri incoming error: $error');
        if (error is FormatException) {
          if (kDebugMode) print('Failed in format initial Uri');
        }
      },
    );
  }
}
