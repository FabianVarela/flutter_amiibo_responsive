import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_amiibo_responsive/app.dart';
import 'package:flutter_amiibo_responsive/bootstrap.dart';
import 'package:win32_registry/win32_registry.dart';

Future<void> main() async {
  await bootstrap(MyApp.new);
  await _registerWinDeepLink('amiiboapp');
}

Future<void> _registerWinDeepLink(String scheme) async {
  if (defaultTargetPlatform != TargetPlatform.windows) return;

  final protocolRegKey = 'Software\\Classes\\$scheme';
  const protocolRegValue = RegistryValue(
    'URL Protocol',
    RegistryValueType.string,
    '',
  );

  const protocolCmdRegKey = r'shell\open\command';
  final protocolCmdRegValue = RegistryValue(
    '',
    RegistryValueType.string,
    '"${Platform.resolvedExecutable}" "%1"',
  );

  final regKey = Registry.currentUser.createKey(protocolRegKey)
    ..createValue(protocolRegValue);

  regKey.createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);
}
