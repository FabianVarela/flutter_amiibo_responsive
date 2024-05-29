import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/config/amiibo_configuration.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

enum AmiiboPath {
  home('amiibos'),
  detail('amiibo'),
  notFound('404');

  const AmiiboPath(this.name);

  final String name;
}

extension _StringPathX on String {
  Uri get toUri => Uri.parse(this);
}

class AmiiboInfoParser extends RouteInformationParser<AmiiboConfiguration> {
  @override
  Future<AmiiboConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final segments = routeInformation.uri.pathSegments
        .map((seg) => seg.toLowerCase())
        .toList();

    switch (segments.length) {
      case 0:
        return const AmiiboConfigurationHome();
      case 1:
        if (segments[0] == AmiiboPath.home.name) {
          return const AmiiboConfigurationHome();
        }
      case 2:
        if (segments[0] == AmiiboPath.home.name && _hasType(segments[1])) {
          return AmiiboConfigurationHome(type: segments[1]);
        }
      case 3:
        if (segments[0] == AmiiboPath.home.name) {
          if (segments[1] == AmiiboPath.detail.name) {
            return AmiiboConfigurationDetail(amiiboId: segments[2]);
          }
        }
      case 4:
        if (segments[0] == AmiiboPath.home.name && _hasType(segments[1])) {
          if (segments[2] == AmiiboPath.detail.name) {
            return AmiiboConfigurationDetail(
              amiiboId: segments[3],
              type: segments[1],
            );
          }
        }
    }

    return const AmiiboConfigurationUnknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AmiiboConfiguration configuration) {
    final home = AmiiboPath.home.name;
    final detail = AmiiboPath.detail.name;
    final noFound = AmiiboPath.notFound.name;

    return switch (configuration) {
      AmiiboConfigurationUnknown() => RouteInformation(uri: '/$noFound'.toUri),
      AmiiboConfigurationHome(:final type) => type != null
          ? RouteInformation(uri: '/$home/$type'.toUri)
          : RouteInformation(uri: '/$home'.toUri),
      AmiiboConfigurationDetail(:final amiiboId, :final type) => type != null
          ? RouteInformation(uri: '/$home/$type/$detail/$amiiboId'.toUri)
          : RouteInformation(uri: '/$home/$detail/$amiiboId'.toUri),
    };
  }

  bool _hasType(String type) {
    return AmiiboType.values.where((el) => el.name == type).isNotEmpty;
  }
}
