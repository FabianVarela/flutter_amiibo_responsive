import 'package:freezed_annotation/freezed_annotation.dart';

part 'amiibo_configuration.freezed.dart';

@freezed
sealed class AmiiboConfiguration with _$AmiiboConfiguration {
  const factory AmiiboConfiguration.home({String? type}) =
      AmiiboConfigurationHome;

  const factory AmiiboConfiguration.detail(String amiiboId, {String? type}) =
      AmiiboConfigurationDetail;

  const factory AmiiboConfiguration.unknown() = AmiiboConfigurationUnknown;
}
