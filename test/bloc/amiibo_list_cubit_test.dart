import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_cubit.dart';
import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  const amiiboListState = AmiiboListState();

  late MockAmiiboRepository mockAmiiboRepository;
  late AmiiboListCubit amiiboListCubit;

  setUpAll(() {
    mockAmiiboRepository = MockAmiiboRepository();
    amiiboListCubit = AmiiboListCubit(mockAmiiboRepository);

    registerFallbackValue(amiiboListState);
  });

  group('$AmiiboListCubit', () {
    blocTest<AmiiboListCubit, AmiiboListState>(
      'Emit $AmiiboListState when get $AmiiboModel list',
      build: () {
        final valueList = [getAmiiboModel()];
        when(() => mockAmiiboRepository.getAmiiboList(any()))
            .thenAnswer((_) => Future.value(valueList));

        return amiiboListCubit;
      },
      act: (cubit) => cubit.fetchAmiiboData(null),
      expect: () {
        final amiiboInitial = amiiboListState.copyWith(
          status: AmiiboListStatus.initial,
        );
        final amiiboSuccess = amiiboListState.copyWith(
          status: AmiiboListStatus.success,
          amiiboList: [getAmiiboModel()],
        );

        return <AmiiboListState>[amiiboInitial, amiiboSuccess];
      },
      verify: (_) {
        verify(() => mockAmiiboRepository.getAmiiboList(any()));
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );

    blocTest<AmiiboListCubit, AmiiboListState>(
      'Emit $Exception when get $AmiiboModel list',
      build: () {
        when(() => mockAmiiboRepository.getAmiiboList(any()))
            .thenThrow(Exception());

        return amiiboListCubit;
      },
      act: (cubit) => cubit.fetchAmiiboData(amiiboType),
      expect: () => <AmiiboListState>[],
      verify: (_) {
        verify(() => mockAmiiboRepository.getAmiiboList(any()));
        verifyNoMoreInteractions(mockAmiiboRepository);
      },
    );
  });

  tearDownAll(() {
    amiiboListCubit.close();
  });
}
