import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_state.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  const amiiboItemState = AmiiboItemState();

  late MockAmiiboRepository mockAmiiboRepository;
  late AmiiboItemCubit amiiboItemCubit;

  setUpAll(() {
    mockAmiiboRepository = MockAmiiboRepository();
    amiiboItemCubit = AmiiboItemCubit(mockAmiiboRepository);

    registerFallbackValue(amiiboItemState);
  });

  group('$AmiiboItemCubit', () {
    blocTest<AmiiboItemCubit, AmiiboItemState>(
      'Emit $AmiiboItemState when get $AmiiboModel item',
      build: () {
        final valueItem = getAmiiboModel();
        when(() => mockAmiiboRepository.getAmiiboItem(any(), any()))
            .thenAnswer((_) => Future.value(valueItem));

        return amiiboItemCubit;
      },
      act: (cubit) => cubit.fetchAmiiboItem(null, amiiboId),
      expect: () {
        final amiiboInitial = amiiboItemState.copyWith(
          status: AmiiboItemStatus.initial,
        );
        final amiiboSuccess = amiiboItemState.copyWith(
          status: AmiiboItemStatus.success,
          amiiboItem: getAmiiboModel(),
        );

        return <AmiiboItemState>[amiiboInitial, amiiboSuccess];
      },
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

        return amiiboItemCubit;
      },
      act: (cubit) => cubit.fetchAmiiboItem(amiiboType, amiiboId),
      expect: () => <AmiiboItemState>[],
      verify: (_) {
        verify(() => mockAmiiboRepository.getAmiiboItem(any(), any()));
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );
  });

  tearDownAll(() {
    amiiboItemCubit.close();
  });
}
