import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_series/amiibo_series_cubit.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';

void main() {
  late MockAmiiboRepository mockAmiiboRepository;

  const amiiboSeriesModel1 = AmiiboSeriesModel(
    key: '0x05',
    name: 'Animal Crossing',
  );
  const amiiboSeriesModel2 = AmiiboSeriesModel(
    key: '0x06',
    name: '8-bit Mario',
  );

  setUpAll(() {
    mockAmiiboRepository = MockAmiiboRepository();
  });

  group('$AmiiboSeriesCubit', () {
    blocTest<AmiiboSeriesCubit, AmiiboSeriesState>(
      'Emit $AmiiboSeriesStateSuccess when fetchAmiiboSeries succeeds',
      build: () {
        when(
          () => mockAmiiboRepository.getAmiiboSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenAnswer(
          (_) => Future.value([amiiboSeriesModel1, amiiboSeriesModel2]),
        );

        return AmiiboSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchAmiiboSeries(),
      expect: () => <AmiiboSeriesState>[
        const AmiiboSeriesStateLoading(),
        const AmiiboSeriesStateSuccess(
          amiiboSeriesList: [amiiboSeriesModel2, amiiboSeriesModel1],
        ),
      ],
      verify: (_) {
        verify(
          () => mockAmiiboRepository.getAmiiboSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        );
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<AmiiboSeriesCubit, AmiiboSeriesState>(
      'Emit $AmiiboSeriesStateError when fetchAmiiboSeries fails',
      build: () {
        when(
          () => mockAmiiboRepository.getAmiiboSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenThrow(Exception());

        return AmiiboSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchAmiiboSeries(),
      expect: () => <AmiiboSeriesState>[
        const AmiiboSeriesStateLoading(),
        const AmiiboSeriesStateError(),
      ],
      verify: (_) {
        verify(
          () => mockAmiiboRepository.getAmiiboSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        );
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<AmiiboSeriesCubit, AmiiboSeriesState>(
      'Filters duplicate series by name',
      build: () {
        const duplicate = AmiiboSeriesModel(
          key: '0x07',
          name: 'Animal Crossing',
        );
        when(
          () => mockAmiiboRepository.getAmiiboSeriesList(
            key: any(named: 'key'),
            name: any(named: 'name'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            [amiiboSeriesModel1, duplicate, amiiboSeriesModel2],
          ),
        );

        return AmiiboSeriesCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchAmiiboSeries(),
      expect: () => <AmiiboSeriesState>[
        const AmiiboSeriesStateLoading(),
        const AmiiboSeriesStateSuccess(
          amiiboSeriesList: [amiiboSeriesModel2, amiiboSeriesModel1],
        ),
      ],
    );
  });
}
