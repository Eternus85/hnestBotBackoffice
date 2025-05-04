import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hnest/helpers/palette_helper.dart';
import 'app_theme.dart';

enum DeviceDimension {
  small,
  medium,
  big;
}

extension DeviceDimensionToString on DeviceDimension {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum DeviceType {
  android,
  iOS,
  macOS,
  windows,
  linux;
}

enum StyleDimension { normal, medium, bold }

extension DeviceTypeToString on DeviceType {
  String toShortString() {
    return toString().split('.').last;
  }
}

class AutoTheme {
  late BuildContext context;

  AutoTheme({required this.context});

  static String get appName {
    return 'HNEST Server Panel';
  }

  static DeviceType getDeviceType() {
    if (Platform.isIOS) {
      return DeviceType.iOS;
    } else if (Platform.isAndroid) {
      return DeviceType.android;
    } else if (Platform.isLinux) {
      return DeviceType.linux;
    } else if (Platform.isMacOS) {
      return DeviceType.macOS;
    } else if (Platform.isWindows) {
      return DeviceType.windows;
    }
    return DeviceType.android;
  }

  static TextStyle? getH0Style(StyleDimension dim, {Color? forcedColor}) {
    return getH1Style(dim, forcedColor: forcedColor)?.copyWith(fontSize: 40);
  }

  static TextStyle? getH1Style(StyleDimension dim, {Color? forcedColor}) {
    TextStyle? style;
    switch (dim) {
      case StyleDimension.normal:
        style = globalTheme.theme.textTheme.titleSmall;
      case StyleDimension.medium:
        style = globalTheme.theme.textTheme.titleMedium;
      case StyleDimension.bold:
        style = globalTheme.theme.textTheme.titleLarge;
    }
    if (forcedColor != null) {
      return style?.copyWith(color: forcedColor);
    }
    return style;
  }

  static TextStyle? getH2Style(StyleDimension dim, {Color? forcedColor}) {
    TextStyle? style;
    switch (dim) {
      case StyleDimension.normal:
        style = globalTheme.theme.textTheme.headlineSmall;
      case StyleDimension.medium:
        style = globalTheme.theme.textTheme.headlineMedium;
      case StyleDimension.bold:
        style = globalTheme.theme.textTheme.headlineLarge;
    }
    if (forcedColor != null) {
      return style?.copyWith(color: forcedColor);
    }
    return style;
  }

  static TextStyle? getH3Style(StyleDimension dim, {Color? forcedColor}) {
    TextStyle? style;
    switch (dim) {
      case StyleDimension.normal:
        style = globalTheme.theme.textTheme.bodySmall;
      case StyleDimension.medium:
        style = globalTheme.theme.textTheme.bodyMedium;
      case StyleDimension.bold:
        style = globalTheme.theme.textTheme.bodyLarge;
    }
    if (forcedColor != null) {
      return style?.copyWith(color: forcedColor);
    }
    return style;
  }

  static TextStyle? getH4Style(StyleDimension dim, {bool error = false, Color? forcedColor}) {
    TextStyle? style;
    switch (dim) {
      case StyleDimension.normal:
        style = globalTheme.theme.textTheme.labelSmall;
        break;
      case StyleDimension.medium:
        style = globalTheme.theme.textTheme.labelMedium;
        break;
      case StyleDimension.bold:
        style = globalTheme.theme.textTheme.labelLarge;
        break;
    }

    if (forcedColor != null) {
      return style?.copyWith(color: forcedColor);
    }
    if (error) {
      return style?.copyWith(color: PaletteHelper.getColor(AppColorId.fieldError.value));
    }
    return style;
  }

  static TextStyle? getInputTextStyle(bool isDisabled, StyleDimension dim, {Color? forcedColor}) {
    TextStyle? style;
    switch (dim) {
      case StyleDimension.normal:
        style = globalTheme.theme.textTheme.bodySmall;
        break;
      case StyleDimension.medium:
        style = globalTheme.theme.textTheme.bodyMedium;
        break;
      case StyleDimension.bold:
        style = globalTheme.theme.textTheme.bodyLarge;
        break;
    }

    var color = forcedColor ?? PaletteHelper.getColor(AppColorId.textBody.value);
    if (isDisabled) {
      color = color.withOpacity(PaletteHelper.disabledOpacity);
    }
    return style?.copyWith(color: color, fontWeight: FontWeight.normal);
  }

  static InputDecoration? getInputDecoration(bool isDisabled, StyleDimension dim, String text, String? errorText,
      {String? icon}) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.decoratedBoxCardNegativeLight.value)),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.fieldError.value)),
            borderRadius: BorderRadius.circular(15.0)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.decoratedBoxCardNegativeLight.value)),
            borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.decoratedBoxCardNegativeLight.value)),
            borderRadius: BorderRadius.circular(15.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteHelper.getColor(AppColorId.fieldError.value)),
            borderRadius: BorderRadius.circular(15.0)),
        suffixIcon: Image.asset("assets/images/$icon", width: 44.0, height: 44.0, fit: BoxFit.scaleDown),
        labelText: text,
        errorText: errorText,
        errorStyle: AutoTheme.getH4Style(StyleDimension.normal, error: true),
        labelStyle: AutoTheme.getInputTextStyle(true, StyleDimension.normal));
  }
}
