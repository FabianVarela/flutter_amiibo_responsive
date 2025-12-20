import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/utils/adaptive_contextual_layout.dart';
import 'package:flutter_amiibo_responsive/view/home_page.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  group('$HomePage UI screen', () {
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
        unawaited(binding.setSurfaceSize(null));

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    }

    testWidgets('Show $HomePage screen with data', (tester) async {
      await tester.runAsync(() async {
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        await setDeviceSize(tester, binding);

        when(
          () => amiiboRepository.getAmiiboList(any()),
        ).thenAnswer((_) => Future.value([amiiboModel]));
        await pumpMainScreen(tester);

        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Amiibo App'),
          ),
          findsOneWidget,
        );

        if (currentDevice == DeviceSegment.mobile) {
          expect(find.byIcon(Icons.menu), findsOneWidget);
        }

        expect(find.byType(ShimmerGridLoading), findsOneWidget);
        await tester.pumpAndSettle();

        expect(find.byType(ShimmerGridLoading), findsNothing);
        expect(find.byType(GridView), findsOneWidget);

        final name = amiiboModel.name;
        final type = amiiboModel.type;
        final image = amiiboModel.imageUrl;
        final character = amiiboModel.character;
        final gameSeries = amiiboModel.gameSeries;

        expect(tester.widgetList(find.byType(AmiiboItem)), [
          isA<AmiiboItem>()
              .having((w) => w.amiibo.name, 'name', name)
              .having((w) => w.amiibo.type, 'type', type)
              .having((w) => w.amiibo.imageUrl, 'imageUrl', image)
              .having((w) => w.amiibo.character, 'character', character)
              .having((w) => w.amiibo.gameSeries, 'gameSeries', gameSeries),
        ]);

        resetSize(tester, binding);
      });
    }, variant: TargetPlatformVariant.all());

    testWidgets(
      'Show $HomePage screen with empty data',
      (tester) async {
        await tester.runAsync(() async {
          when(
            () => amiiboRepository.getAmiiboList(any()),
          ).thenAnswer((_) => Future.value([]));
          await pumpMainScreen(tester);

          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Amiibo App'),
            ),
            findsOneWidget,
          );
          expect(find.byType(ShimmerGridLoading), findsOneWidget);
          await tester.pumpAndSettle();

          expect(find.byType(ShimmerGridLoading), findsNothing);
          expect(find.text('No data found'), findsOneWidget);
        });
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      'Show $HomePage screen with $Exception',
      (tester) async {
        await tester.runAsync(() async {
          when(
            () => amiiboRepository.getAmiiboList(any()),
          ).thenThrow(Exception('Error to get data'));
          await pumpMainScreen(tester);

          expect(find.byType(CircularProgressIndicator), findsNothing);
          await tester.pumpAndSettle();
          expect(find.text('Error to get data'), findsOneWidget);
        });
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets('Show $DrawerMenu, select an option', (tester) async {
      await tester.runAsync(() async {
        final binding = TestWidgetsFlutterBinding.ensureInitialized();
        await setDeviceSize(tester, binding);

        when(
          () => amiiboRepository.getAmiiboList(any()),
        ).thenAnswer((_) => Future.value([amiiboModel]));
        when(
          () => amiiboRepository.getAmiiboItem(any(), any()),
        ).thenAnswer((_) => Future.value(amiiboModel));

        await pumpMainScreen(tester);

        expect(find.byType(ShimmerGridLoading), findsOneWidget);
        await tester.pumpAndSettle();

        expect(find.byType(ShimmerGridLoading), findsNothing);
        expect(find.byType(GridView), findsOneWidget);

        if (currentDevice == DeviceSegment.mobile) {
          await tester.dragFrom(
            tester.getTopLeft(find.byType(MaterialApp)),
            const Offset(300, 0),
          );
          await tester.pumpAndSettle();
          expect(find.byType(Drawer), findsOneWidget);

          final findIcon = find.byIcon(Icons.account_box);
          expect(findIcon, findsOneWidget);

          await tester.tap(findIcon);
          await tester.pumpAndSettle(const Duration(seconds: 1));
        }

        final foundAmiiboItem = find.descendant(
          of: find.byType(GridView),
          matching: find.byType(AmiiboItem),
        );
        expect(foundAmiiboItem, findsOneWidget);

        resetSize(tester, binding);
      });
    }, variant: TargetPlatformVariant.all());
  });
}
