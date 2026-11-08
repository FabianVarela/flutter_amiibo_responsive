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
  final protocolCmdRegValue = RegistryValue.string(
    '"${Platform.resolvedExecutable}" "%1"',
  );

  final regKey = CURRENT_USER.create('Software\\Classes\\$scheme')
    ..setValue('URL Protocol', const RegistryValue.string(''));

  regKey.create(r'shell\open\command')
    ..setValue('', protocolCmdRegValue)
    ..close();

  regKey.close();
}
