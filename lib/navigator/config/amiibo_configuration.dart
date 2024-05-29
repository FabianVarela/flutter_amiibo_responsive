sealed class AmiiboConfiguration {
  const AmiiboConfiguration();
}

class AmiiboConfigurationHome extends AmiiboConfiguration {
  const AmiiboConfigurationHome({this.type});

  final String? type;
}

class AmiiboConfigurationDetail extends AmiiboConfiguration {
  const AmiiboConfigurationDetail({required this.amiiboId, this.type});

  final String amiiboId;
  final String? type;
}

class AmiiboConfigurationUnknown extends AmiiboConfiguration {
  const AmiiboConfigurationUnknown();
}
