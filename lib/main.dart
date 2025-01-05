import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_amiibo_responsive/app.dart';
import 'package:flutter_amiibo_responsive/bootstrap.dart';
import 'package:win32_registry/win32_registry.dart';

Future<void> main() async {
  await bootstrap(MyApp.new);
  if (defaultTargetPlatform == TargetPlatform.windows) {
    await _registerWinDeepLink('amiiboapp');
  }
}

Future<void> _registerWinDeepLink(String scheme) async {
  const protocolRegValue = RegistryValue(
    'URL Protocol',
    RegistryValueType.string,
    '',
  );

  final protocolCmdRegValue = RegistryValue(
    '',
    RegistryValueType.string,
    '"${Platform.resolvedExecutable}" "%1"',
  );

  final regKey = Registry.currentUser.createKey('Software\\Classes\\$scheme')
    ..createValue(protocolRegValue);
  regKey.createKey(r'shell\open\command').createValue(protocolCmdRegValue);
}
