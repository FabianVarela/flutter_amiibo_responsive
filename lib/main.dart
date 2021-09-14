import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Amiibo');
    setWindowMinSize(const Size(800, 500));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = AmiiboRouterDelegate();
  final _informationParser = AmiiboInfoParser();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AmiiboListCubit(
            AmiiboRepository(AmiiboClient(Client())),
          ),
        ),
        BlocProvider(
          create: (_) => AmiiboItemCubit(
            AmiiboRepository(AmiiboClient(Client())),
          ),
        )
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
