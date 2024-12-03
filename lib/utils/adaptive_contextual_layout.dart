import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenType { desktop, tablet, handset, watch }

enum DeviceSegment { mobile, desktop, mobileWeb, desktopWeb, other }

List<DeviceSegment> webSegments = [
  DeviceSegment.mobileWeb,
  DeviceSegment.desktopWeb,
];

DeviceSegment get currentDevice {
  return switch (defaultTargetPlatform) {
    TargetPlatform.android ||
    TargetPlatform.iOS =>
      kIsWeb ? DeviceSegment.mobileWeb : DeviceSegment.mobile,
    TargetPlatform.windows ||
    TargetPlatform.linux ||
    TargetPlatform.macOS =>
      kIsWeb ? DeviceSegment.desktopWeb : DeviceSegment.desktop,
    _ => DeviceSegment.other,
  };
}

extension AdaptiveLayoutContext on BuildContext {
  ScreenType get formFactor {
    return switch (MediaQuery.sizeOf(this).width) {
      >= 840 => ScreenType.desktop,
      >= 600 => ScreenType.tablet,
      >= 300 => ScreenType.handset,
      _ => ScreenType.watch
    };
  }
}
