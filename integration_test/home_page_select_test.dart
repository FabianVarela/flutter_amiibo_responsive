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
import 'package:mocktail_image_network/mocktail_image_network.dart';

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

  testWidgets('Show another data in home view', (tester) async {
    await mockNetworkImages(() {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [RepositoryProvider.value(value: repository)],
          child: const MyApp(),
        ),
      );
    });

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    expect(find.byType(DrawerMenu), findsOneWidget);
    await tester.tap(find.text('Figure'));

    await tester.pump();
    expect(find.byType(ShimmerGridLoading), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(ShimmerGridLoading), findsNothing);
    expect(find.byType(GridView), findsOneWidget);
  });
}
