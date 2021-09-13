import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/home_page_ui.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  group('$HomePageUI UI screen', () {
    late MockAmiiboClient mockAmiiboClient;
    late AmiiboRepository amiiboRepository;
    late AmiiboListCubit amiiboListCubit;

    late MockNavigator mockNavigator;

    setUpAll(() {
      HttpOverrides.global = null;

      mockAmiiboClient = MockAmiiboClient();
      amiiboRepository = AmiiboRepository(mockAmiiboClient);
      amiiboListCubit = AmiiboListCubit(amiiboRepository);

      registerFallbackValue(const AmiiboListState());
      registerFallbackValue(MyAmiiboFake());

      mockNavigator = MockNavigator();
      registerFallbackValue(MyRouteFake());
    });

    Future<void> _pumpMainScreen(WidgetTester tester, Widget child) async {
      await mockNetworkImagesFor(() {
        return tester.pumpWidget(MultiBlocProvider(
          providers: [BlocProvider.value(value: amiiboListCubit)],
          child: MaterialApp(navigatorObservers: [mockNavigator], home: child),
        ));
      });
    }

    testWidgets('Show $HomePageUI screen with data', (tester) async {
      final model = getAmiiboModel();
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([model]),
        ),
      );

      await _pumpMainScreen(
        tester,
        HomePageUI(onChangeType: (_) {}, onGoToDetail: (_) {}),
      );

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

    testWidgets('Show $HomePageUI screen portrait with data', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      final model = getAmiiboModel();
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([model]),
        ),
      );

      await _pumpMainScreen(
        tester,
        HomePageUI(onChangeType: (_) {}, onGoToDetail: (_) {}),
      );

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

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });

    testWidgets('Show $HomePageUI screen with empty data', (tester) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value([]),
        ),
      );

      await _pumpMainScreen(
        tester,
        HomePageUI(onChangeType: (_) {}, onGoToDetail: (_) {}),
      );

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

    testWidgets('Show $HomePageUI screen with $Exception', (tester) async {
      when(() => amiiboRepository.getAmiiboList(any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => throw Exception(),
        ),
      );

      await _pumpMainScreen(
        tester,
        HomePageUI(onChangeType: (_) {}, onGoToDetail: (_) {}),
      );

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
  });
}
