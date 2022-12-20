import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/app.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/widgets/amiibo_item.dart';
import 'package:flutter_amiibo_responsive/view/widgets/shimmer_grid_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockClient extends Mock implements Client {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockClient mockClient;
  late AmiiboClient client;
  late AmiiboRepository repository;

  setUpAll(() {
    mockClient = MockClient();
    client = AmiiboClient(mockClient);
    repository = AmiiboRepository(client);
  });

  testWidgets('Show detail item from home view', (tester) async {
    await mockNetworkImagesFor(() {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [RepositoryProvider.value(value: repository)],
          child: const MyApp(),
        ),
      );
    });

    expect(find.byType(ShimmerGridLoading), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(ShimmerGridLoading), findsNothing);
    expect(find.byType(GridView), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    final findAmiiboType = find.byType(AmiiboItem);
    expect(findAmiiboType, findsWidgets);

    final foundItem = find.descendant(
      of: find.byType(GridView),
      matching: find.byKey(const ValueKey('0')),
    );
    expect(foundItem, findsOneWidget);

    await tester.tap(foundItem);
  });
}

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  var timerDone = false;
  final timer = Timer(
    timeout,
    () => throw TimeoutException('Pump until has timed out'),
  );

  while (timerDone != true) {
    await tester.pump();
    final found = tester.any(finder);
    if (found) timerDone = true;
  }
  timer.cancel();
}
