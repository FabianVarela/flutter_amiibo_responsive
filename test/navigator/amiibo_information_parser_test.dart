import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_information_parser.dart';
import 'package:flutter_amiibo_responsive/navigator/config/amiibo_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AmiiboInfoParser parser;

  setUp(() {
    parser = AmiiboInfoParser();
  });

  group('$AmiiboInfoParser parseRouteInformation', () {
    test('returns AmiiboConfigurationHome for empty path', () async {
      final routeInfo = RouteInformation(uri: Uri.parse('/'));
      final result = await parser.parseRouteInformation(routeInfo);

      expect(result, isA<AmiiboConfigurationHome>());
      expect((result as AmiiboConfigurationHome).type, isNull);
    });

    test('returns AmiiboConfigurationHome for /amiibos', () async {
      final routeInfo = RouteInformation(uri: Uri.parse('/amiibos'));
      final result = await parser.parseRouteInformation(routeInfo);

      expect(result, isA<AmiiboConfigurationHome>());
      expect((result as AmiiboConfigurationHome).type, isNull);
    });

    test(
      'returns AmiiboConfigurationHome with type for /amiibos/figure',
      () async {
        final routeInfo = RouteInformation(uri: Uri.parse('/amiibos/figure'));
        final result = await parser.parseRouteInformation(routeInfo);

        expect(result, isA<AmiiboConfigurationHome>());
        expect((result as AmiiboConfigurationHome).type, equals('figure'));
      },
    );

    test(
      'returns AmiiboConfigurationHome with type for /amiibos/card',
      () async {
        final routeInfo = RouteInformation(uri: Uri.parse('/amiibos/card'));
        final result = await parser.parseRouteInformation(routeInfo);

        expect(result, isA<AmiiboConfigurationHome>());
        expect((result as AmiiboConfigurationHome).type, equals('card'));
      },
    );

    test('returns AmiiboConfigurationDetail for /amiibos/amiibo/123', () async {
      final routeInfo = RouteInformation(
        uri: Uri.parse('/amiibos/amiibo/123'),
      );
      final result = await parser.parseRouteInformation(routeInfo);

      expect(result, isA<AmiiboConfigurationDetail>());
      expect((result as AmiiboConfigurationDetail).amiiboId, equals('123'));
      expect(result.type, isNull);
    });

    test(
      'returns AmiiboConfigurationDetail with type for /amiibos/figure/amiibo/123',
      () async {
        final routeInfo = RouteInformation(
          uri: Uri.parse('/amiibos/figure/amiibo/123'),
        );
        final result = await parser.parseRouteInformation(routeInfo);

        expect(result, isA<AmiiboConfigurationDetail>());
        expect((result as AmiiboConfigurationDetail).amiiboId, equals('123'));
        expect(result.type, equals('figure'));
      },
    );

    test('returns AmiiboConfigurationUnknown for invalid path', () async {
      final routeInfo = RouteInformation(
        uri: Uri.parse('/invalid/path/too/many/segments'),
      );
      final result = await parser.parseRouteInformation(routeInfo);

      expect(result, isA<AmiiboConfigurationUnknown>());
    });

    test(
      'returns AmiiboConfigurationUnknown for unknown single segment',
      () async {
        final routeInfo = RouteInformation(uri: Uri.parse('/unknown'));
        final result = await parser.parseRouteInformation(routeInfo);

        expect(result, isA<AmiiboConfigurationUnknown>());
      },
    );
  });

  group('$AmiiboInfoParser restoreRouteInformation', () {
    test('returns /404 for AmiiboConfigurationUnknown', () {
      const config = AmiiboConfigurationUnknown();
      final result = parser.restoreRouteInformation(config);

      expect(result?.uri.path, equals('/404'));
    });

    test('returns /amiibos for AmiiboConfigurationHome without type', () {
      const config = AmiiboConfigurationHome();
      final result = parser.restoreRouteInformation(config);

      expect(result?.uri.path, equals('/amiibos'));
    });

    test('returns /amiibos/figure for AmiiboConfigurationHome with type', () {
      const config = AmiiboConfigurationHome(type: 'figure');
      final result = parser.restoreRouteInformation(config);

      expect(result?.uri.path, equals('/amiibos/figure'));
    });

    test(
      'returns /amiibos/amiibo/123 for AmiiboConfigurationDetail without type',
      () {
        const config = AmiiboConfigurationDetail(amiiboId: '123');
        final result = parser.restoreRouteInformation(config);

        expect(result?.uri.path, equals('/amiibos/amiibo/123'));
      },
    );

    test(
      'returns /amiibos/figure/amiibo/123 for AmiiboConfigurationDetail with type',
      () {
        const config = AmiiboConfigurationDetail(
          amiiboId: '123',
          type: 'figure',
        );
        final result = parser.restoreRouteInformation(config);

        expect(result?.uri.path, equals('/amiibos/figure/amiibo/123'));
      },
    );
  });
}
