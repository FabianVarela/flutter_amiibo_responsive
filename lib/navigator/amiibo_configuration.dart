import 'package:equatable/equatable.dart';

class AmiiboPath {
  static const amiiboHome = 'amiibos';
  static const amiiboDetail = 'amiibo';
  static const List<String> types = ['figure', 'card', 'yarn', 'band'];
}

class AmiiboConfiguration extends Equatable {
  const AmiiboConfiguration.home({String? valueType})
      : type = valueType,
        amiiboId = null,
        isUnknown = false;

  const AmiiboConfiguration.detail({String? valueType, String? valueId})
      : type = valueType,
        amiiboId = valueId,
        isUnknown = false;

  const AmiiboConfiguration.unknown()
      : type = null,
        amiiboId = null,
        isUnknown = true;

  final String? type;
  final String? amiiboId;
  final bool isUnknown;

  bool get isHomePage => type == null && amiiboId == null && !isUnknown;

  bool get isHomeTypePage => type != null && amiiboId == null && !isUnknown;

  bool get isDetailPage => amiiboId != null && !isUnknown;

  bool get isUnknownPage => isUnknown;

  @override
  List<Object?> get props => [type, amiiboId, isUnknown];
}
