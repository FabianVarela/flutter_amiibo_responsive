import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_state.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  late MockAmiiboRepository mockAmiiboRepository;

  setUpAll(() {
    mockAmiiboRepository = MockAmiiboRepository();
  });

  group('$AmiiboItemCubit', () {
    blocTest<AmiiboItemCubit, AmiiboItemState>(
      'Emit $AmiiboItemState when get $AmiiboModel item',
      build: () {
        when(() => mockAmiiboRepository.getAmiiboItem(any(), any()))
            .thenAnswer((_) => Future.value(amiiboModel));

        return AmiiboItemCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchAmiiboItem(null, amiiboId),
      expect: () => <AmiiboItemState>[
        const AmiiboItemStateInitial(),
        AmiiboItemStateSuccess(amiiboItem: amiiboModel),
      ],
      verify: (_) {
        verify(() => mockAmiiboRepository.getAmiiboItem(any(), any()));
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<AmiiboItemCubit, AmiiboItemState>(
      'Emit $Exception when get $AmiiboModel item',
      build: () {
        when(() => mockAmiiboRepository.getAmiiboItem(any(), any()))
            .thenThrow(Exception());

        return AmiiboItemCubit(mockAmiiboRepository);
      },
      act: (cubit) => cubit.fetchAmiiboItem(amiiboType, amiiboId),
      expect: () => <AmiiboItemState>[
        const AmiiboItemStateInitial(),
        const AmiiboItemStateError(),
      ],
      verify: (_) {
        verify(() => mockAmiiboRepository.getAmiiboItem(any(), any()));
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );
  });
}
