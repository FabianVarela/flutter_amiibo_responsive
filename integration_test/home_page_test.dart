import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/app.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_amiibo_responsive/view/widgets/drawer_menu.dart';
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

  testWidgets('Show data in home view', (tester) async {
    await mockNetworkImagesFor(() {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [RepositoryProvider.value(value: repository)],
          child: const MyApp(),
        ),
      );
    });

    final finderAppBar = find.byType(AppBar);
    final finderText = find.text('Amiibo App');

    expect(
      find.descendant(of: finderAppBar, matching: finderText),
      findsOneWidget,
    );

    final mobilePlatforms = [TargetPlatform.iOS, TargetPlatform.android];
    if (mobilePlatforms.contains(defaultTargetPlatform)) {
      expect(find.byIcon(Icons.menu), findsOneWidget);
    } else {
      expect(find.byType(DrawerMenu), findsOneWidget);
    }

    expect(find.byType(ShimmerGridLoading), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(ShimmerGridLoading), findsNothing);
    expect(find.byType(GridView), findsOneWidget);
  });
}
