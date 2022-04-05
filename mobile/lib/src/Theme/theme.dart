import 'package:flutter/material.dart';

import 'theme_builder.dart';
import 'color_scheme.dart';

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
