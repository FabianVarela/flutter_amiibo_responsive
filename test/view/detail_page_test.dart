import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
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

    late MockNavigator mockNavigator;

    setUpAll(() {
      HttpOverrides.global = null;

      mockAmiiboClient = MockAmiiboClient();
      amiiboRepository = AmiiboRepository(mockAmiiboClient);

      registerFallbackValue(MyAmiiboFake());

      mockNavigator = MockNavigator();
      registerFallbackValue(MyRouteFake());
    });

    Future<void> pumpMainScreen(WidgetTester tester, Widget child) async {
      await mockNetworkImages(() {
        return tester.pumpWidget(
          MultiRepositoryProvider(
            providers: [RepositoryProvider.value(value: amiiboRepository)],
            child: MaterialApp(
              navigatorObservers: [mockNavigator],
              home: child,
            ),
          ),
        );
      });
    }

    testWidgets('Show $DetailPage screen with data', (tester) async {
      when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value(amiiboModel),
        ),
      );

      await pumpMainScreen(
        tester,
        DetailPage(amiiboId: '${amiiboModel.head}${amiiboModel.tail}'),
      );

      final finderAppBar = find.byType(AppBar);
      final finderTextLoading = find.text('Loading');

      expect(
        find.descendant(of: finderAppBar, matching: finderTextLoading),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      final finderTextName = find.text(amiiboModel.name);
      expect(
        find.descendant(of: finderAppBar, matching: finderTextName),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Show $DetailPage screen portrait with data', (tester) async {
      tester.view.physicalSize = const Size(400, 800);

      when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => Future.value(amiiboModel),
        ),
      );

      await pumpMainScreen(
        tester,
        DetailPage(amiiboId: '${amiiboModel.head}${amiiboModel.tail}'),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Show $DetailPage screen with error', (tester) async {
      when(() => amiiboRepository.getAmiiboItem(any(), any())).thenAnswer(
        (_) => Future.delayed(
          const Duration(milliseconds: 100),
          () => throw Exception(),
        ),
      );

      await pumpMainScreen(
        tester,
        DetailPage(amiiboId: '${amiiboModel.head}${amiiboModel.tail}'),
      );

      final finderAppBar = find.byType(AppBar);
      final finderTextLoading = find.text('Loading');

      expect(
        find.descendant(of: finderAppBar, matching: finderTextLoading),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      final finderTextName = find.text('Error');
      expect(
        find.descendant(of: finderAppBar, matching: finderTextName),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.text('Error to get data'), findsOneWidget);
    });
  });
}
