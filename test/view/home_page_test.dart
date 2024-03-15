import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_router_delegate.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
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

    testWidgets('Show $HomePage screen with data', (tester) async {
      final model = getAmiiboModel();
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([model]),
        ),
      );

      await pumpMainScreen(tester);

      final finderAppBar = find.byType(AppBar);
      final finderText = find.text('Amiibo App');

      expect(find.byType(DrawerMenu), findsOneWidget);
      expect(
        find.descendant(of: finderAppBar, matching: finderText),
        findsOneWidget,
      );
      expect(find.byType(ShimmerGridLoading), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ShimmerGridLoading), findsNothing);
      expect(find.byType(GridView), findsOneWidget);

      expect(tester.widgetList(find.byType(AmiiboItem)), [
        isA<AmiiboItem>()
            .having((w) => w.amiibo.name, 'name', model.name)
            .having((w) => w.amiibo.type, 'type', model.type)
            .having((w) => w.amiibo.imageUrl, 'imageUrl', model.imageUrl)
            .having((w) => w.amiibo.character, 'character', model.character)
            .having((w) => w.amiibo.gameSeries, 'gameSeries', model.gameSeries),
      ]);
    });

    testWidgets('Show $HomePage screen portrait with data', (tester) async {
      tester.view.physicalSize = const Size(400, 800);

      final model = getAmiiboModel();
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([model]),
        ),
      );

      await pumpMainScreen(tester);

      final finderIconMenu = find.byIcon(Icons.menu);

      expect(finderIconMenu, findsOneWidget);
      expect(find.byType(ShimmerGridLoading), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ShimmerGridLoading), findsNothing);
      expect(find.byType(GridView), findsOneWidget);

      await tester.tap(finderIconMenu);
      await tester.pump();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(DrawerMenu), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Show $HomePage screen with empty data', (tester) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([]),
        ),
      );

      await pumpMainScreen(tester);

      final finderAppBar = find.byType(AppBar);
      final finderText = find.text('Amiibo App');

      expect(find.byType(DrawerMenu), findsOneWidget);
      expect(
        find.descendant(of: finderAppBar, matching: finderText),
        findsOneWidget,
      );
      expect(find.byType(ShimmerGridLoading), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ShimmerGridLoading), findsNothing);
      expect(find.text('No data found'), findsOneWidget);
    });

    testWidgets('Show $HomePage screen with $Exception', (tester) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => throw Exception(),
        ),
      );

      await pumpMainScreen(tester);

      final finderAppBar = find.byType(AppBar);
      final finderText = find.text('Amiibo App');

      expect(find.byType(DrawerMenu), findsOneWidget);
      expect(
        find.descendant(of: finderAppBar, matching: finderText),
        findsOneWidget,
      );
      expect(find.byType(ShimmerGridLoading), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ShimmerGridLoading), findsNothing);
      expect(find.text('Error to get data'), findsOneWidget);
    });

    testWidgets(
      'Redirect when select an $AmiiboItem to $DetailView screen',
      (tester) async {
        final model = getAmiiboModel();
        when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
          (_) => Future.delayed(
            const Duration(milliseconds: 100),
            () => Future.value([model]),
          ),
        );
        when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
          (_) => Future.delayed(
            const Duration(milliseconds: 100),
            () => Future.value(model),
          ),
        );

        await pumpMainScreen(tester);

        expect(find.byType(ShimmerGridLoading), findsOneWidget);
        await tester.pumpAndSettle();

        expect(find.byType(ShimmerGridLoading), findsNothing);
        expect(find.byType(GridView), findsOneWidget);

        final foundAmiiboItem = find.descendant(
          of: find.byType(GridView),
          matching: find.byType(AmiiboItem),
        );
        expect(foundAmiiboItem, findsOneWidget);

        await tester.tap(foundAmiiboItem);
        await tester.pumpAndSettle();

        expect(find.byType(DetailView), findsOneWidget);
      },
    );

    testWidgets('Show $DrawerMenu and select an option', (tester) async {
      final model = getAmiiboModel();
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([model]),
        ),
      );

      await pumpMainScreen(tester);
      await tester.pumpAndSettle();

      expect(find.byType(ShimmerGridLoading), findsNothing);
      expect(find.byType(GridView), findsOneWidget);

      final scaffoldKey = GlobalKey<ScaffoldState>();
      scaffoldKey.currentState?.openDrawer();

      await tester.pump();
      expect(find.byType(DrawerHeader), findsOneWidget);

      final findIcon = find.byIcon(Icons.account_box);
      expect(findIcon, findsOneWidget);

      await tester.tap(findIcon);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
