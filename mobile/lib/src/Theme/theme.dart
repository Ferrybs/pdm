import 'package:flutter/material.dart';

import 'theme_builder.dart';
import 'color_scheme.dart';

class OnboardingThemeData {
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? iconColor;
  final Color dotColor;
  final Color activeDotColor;

  OnboardingThemeData({
    this.titleStyle,
    this.subtitleStyle,
    this.iconColor,
    this.dotColor = const Color(0xffDBDBDB),
    this.activeDotColor = Colors.brown,
  });
}

extension MyTheme on ThemeData {
  static late OnboardingThemeData _ligthOnBoardingTheme;
  static late OnboardingThemeData _darkOnBoardingTheme;

  OnboardingThemeData get onboardingTheme {
    if (brightness == Brightness.light) {
      return _ligthOnBoardingTheme;
    }
    if (brightness == Brightness.dark) {
      return _darkOnBoardingTheme;
    }
    return OnboardingThemeData();
  }

  setOnboardingTheme(OnboardingThemeData onboardingTheme) {
    if (brightness == Brightness.light) {
      _ligthOnBoardingTheme = onboardingTheme;
    }
    if (brightness == Brightness.dark) {
      _darkOnBoardingTheme = onboardingTheme;
    }
  }
}

class AppTheme {
  static final _baseLightTheme = ThemeData.light();
  static final _baseDarkTheme = ThemeData.dark();

  static get light => ThemeBuilder(
        _baseLightTheme,
        lightColorScheme,
      ).getTheme();
  static get dark => ThemeBuilder(
        _baseDarkTheme,
        darkColorScheme,
      ).getTheme();
}
