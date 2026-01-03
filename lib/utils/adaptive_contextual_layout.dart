import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenType { desktop, tablet, handset, watch }

enum DeviceSegment { mobile, desktop, mobileWeb, desktopWeb, other }

List<DeviceSegment> webSegments = [.mobileWeb, .desktopWeb];

DeviceSegment get currentDevice {
  return switch (defaultTargetPlatform) {
    .android || .iOS => kIsWeb ? .mobileWeb : .mobile,
    .windows || .linux || .macOS => kIsWeb ? .desktopWeb : .desktop,
    _ => .other,
  };
}

extension AdaptiveLayoutContext on BuildContext {
  ScreenType get formFactor {
    return switch (MediaQuery.sizeOf(this).width) {
      >= 840 => .desktop,
      >= 600 => .tablet,
      >= 300 => .handset,
      _ => .watch,
    };
  }
}
