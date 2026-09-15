import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Responsive {
  BuildContext context;
  SizingInformation sizingInformation;
  Responsive(this.context,this.sizingInformation);

  DeviceScreenType getResponsive() {
    // Check the sizing information here and return your UI
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      return DeviceScreenType.desktop;
    }

    if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      return DeviceScreenType.tablet;
    }

    if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
      return DeviceScreenType.watch;
    }

    return DeviceScreenType.watch;
  }
}
