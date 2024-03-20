import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriLink = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _routerDelegate = AmiiboRouterDelegate();
  final _informationParser = AmiiboInfoParser();

  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initUri();
    if (!kIsWeb) _incomingUri();
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
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        ),
        darkTheme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: _informationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }

  Future<void> _initUri() async {
    if (!_initialUriLink) {
      _initialUriLink = true;

      try {
        final initialUri = await getInitialUri();
        if (initialUri != null) {
          _routerDelegate.parseRoute(initialUri);
        }
      } on PlatformException {
        if (kDebugMode) print('Failed to receive Uri');
      } on FormatException catch (_) {
        if (kDebugMode) print('Failed in format initial Uri');
      }
    }
  }

  Future<void> _incomingUri() async {
    _linkSubscription = uriLinkStream.listen(
      (uri) {
        if (uri != null) {
          _routerDelegate.parseRoute(uri);
        }
      },
      onError: (Object error) {
        if (kDebugMode) print('Uri incoming error: $error');
        if (error is FormatException) {
          if (kDebugMode) print('Failed in format initial Uri');
        }
      },
    );
  }
}
