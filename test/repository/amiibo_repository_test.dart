import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  late MockAmiiboClient mockAmiiboClient;
  late AmiiboRepository amiiboRepository;

  setUpAll(() {
    mockAmiiboClient = MockAmiiboClient();
    amiiboRepository = AmiiboRepository(mockAmiiboClient);

    registerFallbackValue(MyAmiiboFake());
  });

  group('$AmiiboRepository', () {
    test('should get a future with a $List of $AmiiboModel '
        'when getAmiiboList is called', () async {
      // arrange
      final futureValueList = Future.value([amiiboModel]);

      when(
        () => mockAmiiboClient.getAmiiboList(any()),
      ).thenAnswer((_) => futureValueList);

      // act
      final result = amiiboRepository.getAmiiboList(null);
      final listResult = await result;

      // assert
      expect(result, isA<Future<List<AmiiboModel>>>());
      expect(result, equals(futureValueList));

      expect(listResult, isA<List<AmiiboModel>>());
      expect(listResult, equals([amiiboModel]));

      verify(() => mockAmiiboClient.getAmiiboList(any())).called(1);
      verifyNoMoreInteractions(mockAmiiboClient);
    });

    test('should get a future with an $AmiiboModel detail '
        'when getAmiiboItem is called', () async {
      // arrange
      final futureValue = Future.value(amiiboModel);

      when(
        () => mockAmiiboClient.getAmiiboItem(any(), any()),
      ).thenAnswer((_) => futureValue);

      // act
      final result = amiiboRepository.getAmiiboItem(amiiboType, amiiboId);
      final valueResult = await result;

      // assert
      expect(result, isA<Future<AmiiboModel>>());
      expect(result, equals(futureValue));

      expect(valueResult, isA<AmiiboModel>());
      expect(valueResult, equals(amiiboModel));

      verify(() => mockAmiiboClient.getAmiiboItem(any(), any())).called(1);
      verifyNoMoreInteractions(mockAmiiboClient);
    });
  });
}
