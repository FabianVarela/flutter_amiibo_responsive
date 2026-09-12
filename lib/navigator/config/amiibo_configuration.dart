sealed class AmiiboConfiguration {
  const new();
}

final class AmiiboConfigurationHome extends AmiiboConfiguration {
  const new({this.type});

  final String? type;
}

final class AmiiboConfigurationDetail extends AmiiboConfiguration {
  const new({required this.amiiboId, this.type});

  final String amiiboId;
  final String? type;
}

final class AmiiboConfigurationUnknown extends AmiiboConfiguration {
  const new();
}
