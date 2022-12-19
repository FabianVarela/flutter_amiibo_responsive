import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _routerDelegate = AmiiboRouterDelegate();
  final _informationParser = AmiiboInfoParser();

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
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: _informationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
