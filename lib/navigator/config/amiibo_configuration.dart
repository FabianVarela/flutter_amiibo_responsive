sealed class AmiiboConfiguration {
  const AmiiboConfiguration();
}

final class AmiiboConfigurationHome extends AmiiboConfiguration {
  const AmiiboConfigurationHome({this.type});

  final String? type;
}

final class AmiiboConfigurationDetail extends AmiiboConfiguration {
  const AmiiboConfigurationDetail({required this.amiiboId, this.type});

  final String amiiboId;
  final String? type;
}

final class AmiiboConfigurationUnknown extends AmiiboConfiguration {
  const AmiiboConfigurationUnknown();
}
