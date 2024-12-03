import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
import 'package:flutter_amiibo_responsive/view/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  group('$DetailPage UI screen', () {
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

    Future<void> pumpMainScreen(
      WidgetTester tester, {
      bool hasError = false,
    }) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([amiiboModel]),
        ),
      );

      if (hasError) {
        when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
          (_) => Future.delayed(
            const Duration(milliseconds: 100),
            () => throw Exception(),
          ),
        );
      } else {
        when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
          (_) => Future.delayed(
            const Duration(milliseconds: 100),
            () => Future.value(amiiboModel),
          ),
        );
      }

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

    testWidgets('Show $DetailPage screen with data', (tester) async {
      await pumpMainScreen(tester);
      await tester.pumpAndSettle();

      amiiboRouterDelegate.amiiboId = amiiboId;

      await tester.pumpAndSettle();
      expect(find.byType(DetailView), findsOneWidget);

      final finderAppBar = find.byType(AppBar);
      expect(finderAppBar, findsOneWidget);

      expect(
        find.descendant(
          of: finderAppBar,
          matching: find.text(amiiboModel.name),
        ),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Show $DetailPage screen landscape with data', (tester) async {
      tester.view.physicalSize = const Size(600, 800);

      await pumpMainScreen(tester);
      await tester.pumpAndSettle();

      amiiboRouterDelegate.amiiboType = amiiboType;
      await tester.pumpAndSettle();
      amiiboRouterDelegate.amiiboId = amiiboId;

      await tester.pumpAndSettle();

      expect(find.byType(DetailView), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Image), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Show $DetailPage screen with error', (tester) async {
      await pumpMainScreen(tester, hasError: true);
      await tester.pumpAndSettle();

      amiiboRouterDelegate.amiiboId = amiiboId;

      await tester.pumpAndSettle();
      expect(find.byType(DetailView), findsOneWidget);

      final finderAppBar = find.byType(AppBar);
      expect(
        find.descendant(of: finderAppBar, matching: find.text('Error')),
        findsOneWidget,
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Error to get data'), findsOneWidget);

      await tester.tap(
        find.descendant(of: finderAppBar, matching: find.byType(Icon)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomePageView), findsOneWidget);
    });
  });
}
