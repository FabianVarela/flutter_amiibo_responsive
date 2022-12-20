import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/view/unknown_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mocks.dart';

void main() {
  late MockNavigator mockNavigator;

  setUpAll(() {
    mockNavigator = MockNavigator();
  });

  Future<void> pumpMainScreen(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        home: child,
        navigatorObservers: [mockNavigator],
      ),
    );
  }

  group('$UnknownPageUI UI screen', () {
    testWidgets('Show $UnknownPageUI screen', (tester) async {
      await pumpMainScreen(tester, const UnknownPageUI());

      expect(find.text('Not found'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.textContaining('Screen not found'), findsOneWidget);
    });
  });
}
