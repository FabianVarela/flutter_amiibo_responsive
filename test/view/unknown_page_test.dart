import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/unknown_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  late MockAmiiboClient mockAmiiboClient;
  late AmiiboRepository amiiboRepository;

  late final AmiiboRouterDelegate amiiboRouterDelegate;
  late final AmiiboInfoParser amiiboInfoParser;

  setUpAll(() {
    HttpOverrides.global = null;

    mockAmiiboClient = MockAmiiboClient();
    amiiboRepository = AmiiboRepository(mockAmiiboClient);

    registerFallbackValue(MyAmiiboFake());

    amiiboRouterDelegate = AmiiboRouterDelegate();
    amiiboInfoParser = AmiiboInfoParser();
  });

  Future<void> pumpMainScreen(WidgetTester tester) async {
    await mockNetworkImages(() {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [RepositoryProvider.value(value: amiiboRepository)],
          child: MaterialApp.router(
            routerDelegate: amiiboRouterDelegate,
            routeInformationParser: amiiboInfoParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ),
      );
    });
  }

  group('$UnknownPageUI UI screen', () {
    testWidgets('Force the redirect to a $UnknownPageUI', (tester) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([amiiboModel]),
        ),
      );

      await pumpMainScreen(tester);
      await tester.pumpAndSettle();

      amiiboRouterDelegate.is404 = true;

      await tester.pumpAndSettle();
      expect(find.byType(UnknownPageUI), findsOneWidget);

      expect(find.text('Not found'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.textContaining('Screen not found'), findsOneWidget);
    });
  });
}
