import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../mock/mocks.dart';
import '../mock/params_factory.dart';

void main() {
  late MockClient mockClient;
  late AmiiboClient amiiboClient;

  setUpAll(() {
    mockClient = MockClient();
    amiiboClient = AmiiboClient(mockClient);

    registerFallbackValue(MyUriFake());
    registerFallbackValue(MyAmiiboFake());
  });

  group('$AmiiboClient for $AmiiboModel list', () {
    test('Get $AmiiboModel list from client mock no type', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response(jsonListResponse, 200));

      // act
      final futureResult = amiiboClient.getAmiiboList(null);
      final listResult = await futureResult;

      // assert
      expect(futureResult, isA<Future<List<AmiiboModel>>>());
      expect(listResult, isA<List<AmiiboModel>>());

      verify(() => mockClient.get(any())).called(1);
    });

    test('Get $AmiiboModel list from client mock with type', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response(jsonListResponse, 200));

      // act
      final futureResult = amiiboClient.getAmiiboList(amiiboType);
      final listResult = await futureResult;

      // assert
      expect(futureResult, isA<Future<List<AmiiboModel>>>());
      expect(listResult, isA<List<AmiiboModel>>());

      verify(() => mockClient.get(any())).called(1);
    });

    test('Get $Exception when get amiibo list from mock', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response('Error to get list', 500));

      // act
      final futureResult = amiiboClient.getAmiiboList(null);

      // assert
      expect(futureResult, throwsA(isA<Exception>()));
      verify(() => mockClient.get(any())).called(1);
    });
  });

  group('$AmiiboClient for $AmiiboModel detail', () {
    test('Get $AmiiboModel detail from client mock no type', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response(jsonDetailResponse, 200));

      // act
      final futureResult = amiiboClient.getAmiiboItem(null, amiiboId);
      final detailResult = await futureResult;

      // assert
      expect(futureResult, isA<Future<AmiiboModel>>());
      expect(detailResult, isA<AmiiboModel>());

      verify(() => mockClient.get(any())).called(1);
    });

    test('Get $AmiiboModel detail from client mock with type', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response(jsonDetailResponse, 200));

      // act
      final futureResult = amiiboClient.getAmiiboItem(amiiboType, amiiboId);
      final detailResult = await futureResult;

      // assert
      expect(futureResult, isA<Future<AmiiboModel>>());
      expect(detailResult, isA<AmiiboModel>());

      verify(() => mockClient.get(any())).called(1);
    });

    test('Get $Exception when get amiibo detail from mock', () async {
      // arrange
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response('Error to get deatil', 500));

      // act
      final futureResult = amiiboClient.getAmiiboItem(null, amiiboId);

      // assert
      expect(futureResult, throwsA(isA<Exception>()));
      verify(() => mockClient.get(any())).called(1);
    });
  });
}
