import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/game_series/game_series_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_amiibo_responsive/view/home/widgets/drawer_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mocks.dart';

void main() {
  late MockAmiiboRepository mockAmiiboRepository;
  late GameSeriesCubit gameSeriesCubit;

  const gameSeriesModel1 = GameSeriesModel(
    key: '0x000',
    name: 'Super Smash Bros.',
  );
  const gameSeriesModel2 = GameSeriesModel(
    key: '0x001',
    name: 'The Legend of Zelda',
  );

  setUp(() {
    mockAmiiboRepository = MockAmiiboRepository();
  });

  tearDown(() async {
    await gameSeriesCubit.close();
  });

  Widget buildWidget({
    String? selectedType,
    String? selectedGameSeries,
    ValueSetter<String?>? onSelectType,
    ValueSetter<String?>? onSelectGameSeries,
    bool makePop = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<GameSeriesCubit>.value(
          value: gameSeriesCubit,
          child: DrawerMenu(
            selectedType: selectedType,
            selectedGameSeries: selectedGameSeries,
            onSelectType: onSelectType ?? (_) {},
            onSelectGameSeries: onSelectGameSeries ?? (_) {},
            makePop: makePop,
          ),
        ),
      ),
    );
  }

  group('$DrawerMenu', () {
    testWidgets('shows game series list when state is success', (
      tester,
    ) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel1, gameSeriesModel2]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.text('GAME SERIES'), findsOneWidget);
      expect(find.text('Super Smash Bros.'), findsOneWidget);
      expect(find.text('The Legend of Zelda'), findsOneWidget);
    });

    testWidgets('shows error message when state is error', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenThrow(Exception('Error'));

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.text('Error loading series'), findsOneWidget);
    });

    testWidgets('calls onSelectGameSeries with null when All is tapped', (
      tester,
    ) async {
      String? selectedValue = 'Super Smash Bros.';

      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel1]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(
        buildWidget(
          selectedGameSeries: selectedValue,
          onSelectGameSeries: (value) => selectedValue = value,
        ),
      );

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      final allTile = find.ancestor(
        of: find.byIcon(Icons.apps),
        matching: find.byType(ListTile),
      );
      await tester.tap(allTile);
      await tester.pumpAndSettle();

      expect(selectedValue, isNull);
    });

    testWidgets('calls onSelectGameSeries with series name when tapped', (
      tester,
    ) async {
      String? selectedValue;

      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel1, gameSeriesModel2]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(
        buildWidget(onSelectGameSeries: (value) => selectedValue = value),
      );

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Super Smash Bros.'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Super Smash Bros.'));
    });

    testWidgets('shows correct icon for Zelda series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel2]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shield), findsOneWidget);
    });

    testWidgets('shows correct icon for Smash Bros series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel1]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.sports_mma), findsOneWidget);
    });

    testWidgets('shows correct icon for Mario series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x002', name: 'Super Mario')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('shows correct icon for Animal Crossing series', (
      tester,
    ) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [
          const GameSeriesModel(key: '0x003', name: 'Animal Crossing'),
        ],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('shows correct icon for Splatoon series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x004', name: 'Splatoon')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('shows correct icon for Pokemon series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x005', name: 'Pokemon')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);
    });

    testWidgets('shows correct icon for Kirby series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x006', name: 'Kirby')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.circle), findsOneWidget);
    });

    testWidgets('shows correct icon for Fire Emblem series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x007', name: 'Fire Emblem')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });

    testWidgets('shows correct icon for Metroid series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [const GameSeriesModel(key: '0x008', name: 'Metroid')],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.rocket), findsOneWidget);
    });

    testWidgets('shows default icon for unknown series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer(
        (_) async => [
          const GameSeriesModel(key: '0x099', name: 'Unknown Series'),
        ],
      );

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget());

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.videogame_asset), findsOneWidget);
    });

    testWidgets('calls onSelectType when format type is tapped', (
      tester,
    ) async {
      String? selectedValue;

      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => <GameSeriesModel>[]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(
        buildWidget(onSelectType: (value) => selectedValue = value),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Figure'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('figure'));
    });

    testWidgets('highlights selected game series', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [gameSeriesModel1]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(
        buildWidget(selectedGameSeries: 'Super Smash Bros.'),
      );

      await gameSeriesCubit.fetchGameSeries();
      await tester.pumpAndSettle();

      final listTile = tester.widget<ListTile>(
        find.ancestor(
          of: find.text('Super Smash Bros.'),
          matching: find.byType(ListTile),
        ),
      );
      expect(listTile.selected, isTrue);
    });

    testWidgets('highlights selected type', (tester) async {
      when(
        () => mockAmiiboRepository.getGameSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => <GameSeriesModel>[]);

      gameSeriesCubit = GameSeriesCubit(mockAmiiboRepository);
      await tester.pumpWidget(buildWidget(selectedType: 'figure'));

      await tester.pumpAndSettle();
      final listTile = tester.widget<ListTile>(
        find.ancestor(
          of: find.text('Figure'),
          matching: find.byType(ListTile),
        ),
      );
      expect(listTile.selected, isTrue);
    });
  });
}
