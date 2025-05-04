import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hnest/helpers/palette_helper.dart';

var globalTheme = AppTheme.shared;

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }
  AppTheme._internal();

  static AppTheme shared = AppTheme();


  ThemeData get theme {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final ThemeData base = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();

    return base.copyWith(
      appBarTheme: AppBarTheme(
        color: PaletteHelper.getColor(AppColorId.textTitle.value),
      ),
      primaryColor: Colors.transparent,
      textTheme: base.textTheme.copyWith(
        //Tutto ciè che esprime un titolo di una videata
          titleLarge:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textTitle.value), fontSize: 24, fontFamily: 'Roboto-Bold', fontWeight: FontWeight.w700),
          titleMedium:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textTitle.value), fontSize: 24, fontFamily: 'Roboto-Medium', fontWeight: FontWeight.w500),
          titleSmall:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textTitle.value), fontSize: 24, fontFamily: 'Roboto-Regular', fontWeight: FontWeight.w400),

          //Tutto ciè che esprime un contenuto secondario ad un titolo
          headlineLarge: TextStyle(
              color: PaletteHelper.getColor(AppColorId.textHeadLine.value), fontSize: 18, fontFamily: 'Roboto-Bold', fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(
              color: PaletteHelper.getColor(AppColorId.textHeadLine.value), fontSize: 18, fontFamily: 'Roboto-Medium', fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(
              color: PaletteHelper.getColor(AppColorId.textHeadLine.value), fontSize: 18, fontFamily: 'Roboto-Regular', fontWeight: FontWeight.w400),

          //Tutto ciè che esprime un contenuto secondario ad un body
          bodyLarge:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textBody.value), fontSize: 15, fontFamily: 'Roboto-Bold', fontWeight: FontWeight.w700),
          bodyMedium:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textBody.value), fontSize: 15, fontFamily: 'Roboto-Medium', fontWeight: FontWeight.w500),
          bodySmall:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textBody.value), fontSize: 15, fontFamily: 'Roboto-Regular', fontWeight: FontWeight.w400),

          //Tutto ciè che esprime un contenuto secondario ad una label
          labelLarge:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textLabel.value), fontSize: 13, fontFamily: 'Roboto-Bold', fontWeight: FontWeight.w700),
          labelMedium:
          TextStyle(color: PaletteHelper.getColor(AppColorId.textLabel.value), fontSize: 13, fontFamily: 'Roboto-Medium', fontWeight: FontWeight.w500),
          labelSmall: TextStyle(
              color: PaletteHelper.getColor(AppColorId.textLabelNormal.value), fontSize: 13, fontFamily: 'Roboto-Regular', fontWeight: FontWeight.w400)),
      listTileTheme: base.listTileTheme.copyWith(textColor: PaletteHelper.getColor(AppColorId.textBody.value)),
      inputDecorationTheme: base.inputDecorationTheme
          .copyWith(fillColor: Colors.white, filled: true, floatingLabelBehavior: FloatingLabelBehavior.never),
      dialogTheme: base.dialogTheme.copyWith(
          titleTextStyle: TextStyle(color: PaletteHelper.getColor(AppColorId.textBody.value), fontSize: 18),
          contentTextStyle: TextStyle(color: PaletteHelper.getColor(AppColorId.textBody.value), fontSize: 14)),
      colorScheme: ColorScheme(
          surface: Colors.transparent,
          onSurface: Colors.transparent,
          brightness: brightness,
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          secondary: Colors.transparent,
          onSecondary: Colors.transparent,
          error: Colors.redAccent,
          onError: Colors.redAccent,
          background: Colors.transparent,
          onBackground: Colors.transparent),
    );
  }
}
