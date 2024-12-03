import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
import 'package:flutter_amiibo_responsive/view/home_page.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/vertical_icon_button.dart';
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
        DeviceSegment.mobile => const Size(400, 800),
        DeviceSegment.desktop => const Size(800, 600),
        _ => const Size(300, 300),
      };

      await binding.setSurfaceSize(size);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
    }

    void resetSize(WidgetTester tester, TestWidgetsFlutterBinding binding) {
      addTearDown(() {
        binding.setSurfaceSize(null);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    }

    Future<void> initMainScreenAndRedirect(
      WidgetTester tester, {
      bool hasError = false,
    }) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.value([amiiboModel]),
      );

      if (hasError) {
        when(() => amiiboRepository.getAmiiboItem(any(), any())).thenThrow(
          Exception(),
        );
      } else {
        when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
          (_) => Future.value(amiiboModel),
        );
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

          expect(find.byType(AppBar), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(amiiboModel.name),
            ),
            findsOneWidget,
          );

          expect(find.byType(CircularProgressIndicator), findsNothing);

          expect(find.byType(Image), findsOneWidget);
          expect(find.text(amiiboModel.amiiboSeries), findsOneWidget);
          expect(find.byType(VerticalIconButton), findsExactly(3));

          resetSize(tester, binding);
        });
      },
      variant: TargetPlatformVariant.all(
        excluding: {TargetPlatform.fuchsia},
      ),
    );

    testWidgets(
      'Show $DetailPage screen with error',
      (tester) async {
        await initMainScreenAndRedirect(tester, hasError: true);

        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Error'),
          ),
          findsOneWidget,
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Error to get data'), findsOneWidget);

        await tester.tap(
          find.descendant(of: find.byType(AppBar), matching: find.byType(Icon)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HomePageView), findsOneWidget);
      },
      variant: TargetPlatformVariant.all(
        excluding: {TargetPlatform.fuchsia},
      ),
    );
  });
}
