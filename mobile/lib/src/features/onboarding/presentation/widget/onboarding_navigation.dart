import 'package:basearch/src/Theme/theme.dart';
import 'package:flutter/material.dart';

class OnboardingNavigation extends StatelessWidget {
  OnboardingNavigation({
    Key? key,
    this.onPreviousClicked,
    this.onNextClicked,
  }) : super(key: key);

  final void Function()? onPreviousClicked;
  final void Function()? onNextClicked;
  late OnboardingThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).onboardingTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createIconButton(onPreviousClicked),
          createIconButton(onNextClicked),
        ],
      ),
    );
  }

  IconButton createIconButton(void Function()? onPreviousClicked) {
    return IconButton(
      icon: Icon(
        onPreviousClicked == null ? null : Icons.arrow_back_ios,
        color: _themeData.iconColor,
      ),
      onPressed: onPreviousClicked,
    );
  }
}
