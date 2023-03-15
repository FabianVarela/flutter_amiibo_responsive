import 'package:equatable/equatable.dart';

class AmiiboPath {
  static const home = 'amiibos';
  static const detail = 'amiibo';
  static const notFound = '404';
}

class AmiiboConfiguration extends Equatable {
  const AmiiboConfiguration.home({this.type})
      : amiiboId = null,
        isUnknown = false;

  const AmiiboConfiguration.detail({this.type, this.amiiboId})
      : isUnknown = false;

  const AmiiboConfiguration.unknown()
      : type = null,
        amiiboId = null,
        isUnknown = true;

  final String? type;
  final String? amiiboId;
  final bool isUnknown;

  bool get isHomePage => type == null && amiiboId == null && !isUnknown;

  bool get isHomeTypePage => type != null && amiiboId == null && !isUnknown;

  bool get isDetailNoTypePage => type == null && amiiboId != null && !isUnknown;

  bool get isDetailPage => type != null && amiiboId != null && !isUnknown;

  bool get isUnknownPage => isUnknown;

  @override
  List<Object?> get props => [type, amiiboId, isUnknown];
}
