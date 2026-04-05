import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_amiibo_responsive/bloc/game_series/game_series_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';

void main() {
  late MockAmiiboRepository mockAmiiboRepository;

  const gameSeriesModel1 = GameSeriesModel(
    key: '0x000',
    name: 'Super Smash Bros.',
  );
  const gameSeriesModel2 = GameSeriesModel(
    key: '0x001',
    name: 'The Legend of Zelda',
  );

  setUpAll(() {
    mockAmiiboRepository = MockAmiiboRepository();
  });

  group('$GameSeriesCubit', () {
    blocTest<GameSeriesCubit, GameSeriesState>(
      'Emit $GameSeriesStateSuccess when fetchGameSeries succeeds',
      build: () {
        when(
          () => mockAmiiboRepository.getGameSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenAnswer((_) => Future.value([gameSeriesModel1, gameSeriesModel2]));

        return GameSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchGameSeries(),
      expect: () => <GameSeriesState>[
        const GameSeriesStateLoading(),
        const GameSeriesStateSuccess(
          gameSeriesList: [gameSeriesModel1, gameSeriesModel2],
        ),
      ],
      verify: (_) {
        verify(
          () => mockAmiiboRepository.getGameSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        );
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<GameSeriesCubit, GameSeriesState>(
      'Emit $GameSeriesStateError when fetchGameSeries fails',
      build: () {
        when(
          () => mockAmiiboRepository.getGameSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenThrow(Exception());

        return GameSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchGameSeries(),
      expect: () => <GameSeriesState>[
        const GameSeriesStateLoading(),
        const GameSeriesStateError(),
      ],
      verify: (_) {
        verify(
          () => mockAmiiboRepository.getGameSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        );
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<GameSeriesCubit, GameSeriesState>(
      'Filters duplicate series by name',
      build: () {
        const duplicate = GameSeriesModel(
          key: '0x002',
          name: 'Super Smash Bros.',
        );
        when(
          () => mockAmiiboRepository.getGameSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenAnswer(
          (_) => Future.value([gameSeriesModel1, duplicate, gameSeriesModel2]),
        );

        return GameSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchGameSeries(),
      expect: () => <GameSeriesState>[
        const GameSeriesStateLoading(),
        const GameSeriesStateSuccess(
          gameSeriesList: [gameSeriesModel1, gameSeriesModel2],
        ),
      ],
    );
  });
}
