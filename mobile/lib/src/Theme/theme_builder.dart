import 'package:basearch/src/Theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeBuilder {
  final ThemeData _baseTheme;
  final ColorScheme _colorScheme;
  ThemeBuilder(this._baseTheme, this._colorScheme);
  getTheme() {
    return _baseTheme.copyWith(
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarTheme,
      textSelectionTheme: textSelectionTheme,
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      textTheme: textTheme,
      textButtonTheme: textButtonTheme,
    )..setOnboardingTheme(onboardingThemeData);
  }

  get onboardingThemeData {
    return OnboardingThemeData(
      titleStyle: titleLarge?.copyWith(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 19.0,
        color: const Color(0xff36455A),
      ),
      subtitleStyle: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color(0xff6A6F7D),
      ),
      activeDotColor: _colorScheme.tertiary,
      iconColor: const Color(0xffA1A8B9),
    );
  }

  get textButtonTheme {
    return TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(_colorScheme.tertiary),
    ));
  }

  get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            _colorScheme.tertiary.withAlpha(128),
          ),
          backgroundColor: MaterialStateProperty.all(
            _colorScheme.tertiary,
          ),
          foregroundColor: MaterialStateProperty.all(
            _colorScheme.onTertiary,
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(200.0, 60.0),
          ),
          fixedSize: MaterialStateProperty.all(
            const Size.fromHeight(60.0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16.0),
          )),
    );
  }

  get inputDecorationTheme {
    return _baseTheme.inputDecorationTheme.copyWith(
      iconColor: _colorScheme.onTertiary,
      border: InputBorder.none,
      fillColor: _colorScheme.tertiary,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _colorScheme.onTertiary,
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
  }

  get textSelectionTheme {
    return _baseTheme.textSelectionTheme.copyWith(
      cursorColor: _colorScheme.onTertiary,
    );
  }

  get appBarTheme {
    return _baseTheme.appBarTheme.copyWith(
      backgroundColor: _colorScheme.background,
      iconTheme: IconThemeData(
        color: _colorScheme.tertiary,
      ),
    );
  }

  get bodyLarge {
    return _baseTheme.textTheme.bodyLarge?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get bodyMedium {
    return _baseTheme.textTheme.bodyMedium?.copyWith(
      color: _colorScheme.secondary,
      fontFamily: "Poppins",
    );
  }

  get bodySmall {
    return _baseTheme.textTheme.bodySmall?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get displayLarge {
    return _baseTheme.textTheme.displayLarge?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get displayMedium {
    return _baseTheme.textTheme.titleMedium?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get displaySmall {
    return _baseTheme.textTheme.displaySmall?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get headlineLarge {
    return _baseTheme.textTheme.headlineLarge?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get headlineMedium {
    return _baseTheme.textTheme.headlineMedium?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get headlineSmall {
    return _baseTheme.textTheme.headlineSmall?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get labelLarge {
    return _baseTheme.textTheme.labelLarge?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get labelMedium {
    return _baseTheme.textTheme.labelMedium?.copyWith(
      fontFamily: "Poppins",
    );
  }

  get labelSmall {
    return _baseTheme.textTheme.labelSmall?.copyWith(
      fontFamily: "Poppins",
    );
  }

  TextStyle? get titleLarge {
    return _baseTheme.textTheme.titleLarge?.copyWith(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      color: _colorScheme.tertiary,
      fontSize: 20,
    );
  }

  get titleMedium {
    return _baseTheme.textTheme.titleMedium?.copyWith(
      color: _colorScheme.secondary,
      fontFamily: "Poppins",
    );
  }

  get titleSmall {
    return _baseTheme.textTheme.titleMedium?.copyWith(
      fontFamily: "Poppins",
    );
  }

  TextTheme get textTheme {
    return _baseTheme.textTheme.copyWith(
      // Material 3 (2021) formats
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,

      // Material 2 formats (Deprecated)
      // display2 = DisplayLarge
      // display3 = DisplayMedium
      // headline1 = DisplaySmall
      // headline2 = HeadlineLarge
      // headline3 = HeadlineMedium
      // headline4 = HeadlineSmall
      // headline5 = TitleLarge
      // subhead1/Subtitle1 = TitleMedium
      // subhead2/Subtitle2 = TitleSmall
      // body1 = BodyLarge
      // body2 = BodyMedium
      // caption = BodySmall
      // button = LabelLarge
      // overline = LabelMedium
      // N/A = LabelSmall
    );
  }

  MaterialColor _material_color() {
    return const MaterialColor(
      0xffc5d8a4, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      <int, Color>{
        50: Color(0xffcbdcad), //10%
        100: Color(0xffd1e0b6), //20%
        200: Color(0xffd6e4bf), //30%
        300: Color(0xffdce8c8), //40%
        400: Color(0xffe2ecd2), //50%
        500: Color(0xffe8efdb), //60%
        600: Color(0xffeef3e4), //70%
        700: Color(0xfff3f7ed), //80%
        800: Color(0xfff9fbf6), //90%
        900: Color(0xffffffff), //100%
      },
    );
  }
}
