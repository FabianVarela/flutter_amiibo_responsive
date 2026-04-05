import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_series/amiibo_series_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_amiibo_responsive/view/home/widgets/filter_chips.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mocks.dart';

void main() {
  late MockAmiiboRepository mockAmiiboRepository;
  late AmiiboSeriesCubit amiiboSeriesCubit;

  const amiiboSeriesModel1 = AmiiboSeriesModel(
    key: '0x05',
    name: 'Animal Crossing',
  );
  const amiiboSeriesModel2 = AmiiboSeriesModel(
    key: '0x06',
    name: 'Super Smash Bros.',
  );

  setUp(() {
    mockAmiiboRepository = MockAmiiboRepository();
  });

  tearDown(() async {
    await amiiboSeriesCubit.close();
  });

  Widget buildWidget({
    String? selectedAmiiboSeries,
    ValueSetter<String?>? onSelectAmiiboSeries,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<AmiiboSeriesCubit>.value(
          value: amiiboSeriesCubit,
          child: FilterChipsSection(
            selectedAmiiboSeries: selectedAmiiboSeries,
            onSelectAmiiboSeries: onSelectAmiiboSeries ?? (_) {},
          ),
        ),
      ),
    );
  }

  group('$FilterChipsSection', () {
    testWidgets('Shows nothing when state is initial', (tester) async {
      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => <AmiiboSeriesModel>[]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(buildWidget());

      expect(find.byType(FilterChip), findsNothing);
      expect(find.text('SERIES'), findsNothing);
    });

    testWidgets('Shows chips when data is loaded', (tester) async {
      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [amiiboSeriesModel1, amiiboSeriesModel2]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(buildWidget());

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      expect(find.text('SERIES'), findsOneWidget);
      expect(find.byType(FilterChip), findsNWidgets(3));
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Animal Crossing'), findsOneWidget);
      expect(find.text('Super Smash Bros.'), findsOneWidget);
    });

    testWidgets('Shows nothing when data is empty', (tester) async {
      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => <AmiiboSeriesModel>[]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(buildWidget());

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      expect(find.byType(FilterChip), findsNothing);
      expect(find.text('SERIES'), findsNothing);
    });

    testWidgets('All chip is selected when selectedAmiiboSeries is null', (
      tester,
    ) async {
      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [amiiboSeriesModel1]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(buildWidget());

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      final allChip = tester.widget<FilterChip>(
        find.widgetWithText(FilterChip, 'All'),
      );
      expect(allChip.selected, isTrue);
    });

    testWidgets('Series chip is selected when selectedAmiiboSeries matches', (
      tester,
    ) async {
      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [amiiboSeriesModel1]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(
        buildWidget(selectedAmiiboSeries: 'Animal Crossing'),
      );

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      final seriesChip = tester.widget<FilterChip>(
        find.widgetWithText(FilterChip, 'Animal Crossing'),
      );
      expect(seriesChip.selected, isTrue);

      final allChip = tester.widget<FilterChip>(
        find.widgetWithText(FilterChip, 'All'),
      );
      expect(allChip.selected, isFalse);
    });

    testWidgets('Calls onSelectAmiiboSeries with null when All is tapped', (
      tester,
    ) async {
      String? selectedValue = 'Animal Crossing';

      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [amiiboSeriesModel1]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(
        buildWidget(
          selectedAmiiboSeries: selectedValue,
          onSelectAmiiboSeries: (value) => selectedValue = value,
        ),
      );

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'All'));
      await tester.pumpAndSettle();

      expect(selectedValue, isNull);
    });

    testWidgets('Calls onSelectAmiiboSeries with series name when tapped', (
      tester,
    ) async {
      String? selectedValue;

      when(
        () => mockAmiiboRepository.getAmiiboSeriesList(
          key: any(named: 'key'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => [amiiboSeriesModel1]);

      amiiboSeriesCubit = AmiiboSeriesCubit(mockAmiiboRepository);

      await tester.pumpWidget(
        buildWidget(onSelectAmiiboSeries: (value) => selectedValue = value),
      );

      await amiiboSeriesCubit.fetchAmiiboSeries();
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Animal Crossing'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Animal Crossing'));
    });
  });
}
