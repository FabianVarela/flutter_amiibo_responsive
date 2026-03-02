import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/detail/detail_page.dart';
import 'package:flutter_amiibo_responsive/view/home/home_page.dart';
import 'package:flutter_amiibo_responsive/view/home/widgets/amiibo_item.dart';
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

      when(
        () => mockAmiiboClient.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) => Future.value([]));

      when(
        () => mockAmiiboClient.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) => Future.value([]));

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

    Future<void> setDeviceSize(
      WidgetTester tester,
      TestWidgetsFlutterBinding binding,
    ) async {
      final size = switch (currentDevice) {
        .mobile => const Size(400, 800),
        .desktop => const Size(800, 600),
        _ => const Size(300, 300),
      };

      await binding.setSurfaceSize(size);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
    }

    void resetSize(WidgetTester tester, TestWidgetsFlutterBinding binding) {
      addTearDown(() {
        unawaited(binding.setSurfaceSize(null));

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    }

    Future<void> initMainScreenAndRedirect(
      WidgetTester tester, {
      bool hasError = false,
    }) async {
      when(
        () => amiiboRepository.getAmiiboList(
          type: any(named: 'type'),
          gameSeries: any(named: 'gameSeries'),
          amiiboSeries: any(named: 'amiiboSeries'),
        ),
      ).thenAnswer((_) => Future.value([amiiboModel]));

      if (hasError) {
        when(
          () => amiiboRepository.getAmiiboItem(any(), any()),
        ).thenThrow(Exception());
      } else {
        when(
          () => amiiboRepository.getAmiiboItem(any(), any()),
        ).thenAnswer((_) => Future.value(amiiboModel));
      }

      await pumpMainScreen(tester);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(GridView), findsOneWidget);

      final foundAmiiboItem = find.descendant(
        of: find.byType(GridView),
        matching: find.byType(AmiiboItem),
      );
      expect(foundAmiiboItem, findsOneWidget);

      await tester.tap(foundAmiiboItem);
      await tester.pumpAndSettle();

      expect(find.byType(DetailPage), findsOneWidget);
    }

    testWidgets(
      'Show $DetailPage screen with data',
      (tester) async {
        await tester.runAsync(() async {
          final binding = TestWidgetsFlutterBinding.ensureInitialized();
          await setDeviceSize(tester, binding);

          await initMainScreenAndRedirect(tester);

          expect(find.byIcon(Icons.arrow_back), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.byType(Image), findsOneWidget);
          expect(find.text(amiiboModel.name), findsOneWidget);
          expect(find.textContaining(amiiboModel.amiiboSeries), findsWidgets);

          expect(
            find.textContaining(amiiboModel.character.toUpperCase()),
            findsWidgets,
          );

          expect(find.text('GAME SERIES'), findsOneWidget);
          expect(find.text('AMIIBO SERIES'), findsOneWidget);
          expect(find.text('TYPE'), findsOneWidget);
          expect(find.text('CHARACTER'), findsOneWidget);

          resetSize(tester, binding);
        });
      },
      variant: TargetPlatformVariant.all(excluding: {.fuchsia}),
    );

    testWidgets('Show $DetailPage screen with error', (tester) async {
      await initMainScreenAndRedirect(tester, hasError: true);

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Error to get data'), findsOneWidget);

      final backButton = find.byIcon(Icons.arrow_back);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(HomePageView), findsOneWidget);
    }, variant: TargetPlatformVariant.all());

    testWidgets(
      'Show $DetailPage with regional releases when release date exists',
      (tester) async {
        await tester.runAsync(() async {
          final binding = TestWidgetsFlutterBinding.ensureInitialized();
          await setDeviceSize(tester, binding);

          await initMainScreenAndRedirect(tester);

          expect(find.text('REGIONAL RELEASES'), findsOneWidget);
          expect(find.text('NORTH AMERICA'), findsOneWidget);
          expect(find.text('JAPAN'), findsOneWidget);
          expect(find.text('EUROPE'), findsOneWidget);
          expect(find.text('AUSTRALIA'), findsOneWidget);

          resetSize(tester, binding);
        });
      },
      variant: TargetPlatformVariant.all(excluding: {.fuchsia}),
    );

    testWidgets(
      'Navigate back using back button',
      (tester) async {
        await tester.runAsync(() async {
          final binding = TestWidgetsFlutterBinding.ensureInitialized();
          await setDeviceSize(tester, binding);

          await initMainScreenAndRedirect(tester);

          await tester.tap(find.byIcon(Icons.arrow_back));
          await tester.pumpAndSettle();

          expect(find.byType(HomePageView), findsOneWidget);
          expect(find.byType(DetailPage), findsNothing);

          resetSize(tester, binding);
        });
      },
      variant: TargetPlatformVariant.all(excluding: {.fuchsia}),
    );
  });
}
