import 'package:basearch/src/Theme/theme.dart';
import 'package:flutter/material.dart';

class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    Key? key,
    this.onPreviousClicked,
    this.onNextClicked,
  }) : super(key: key);

  final void Function()? onPreviousClicked;
  final void Function()? onNextClicked;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              onPreviousClicked == null ? null : Icons.arrow_back_ios,
              color: _themeData.onboardingTheme.iconColor,
            ),
            onPressed: onPreviousClicked,
          ),
          IconButton(
            icon: Icon(
              onNextClicked == null ? null : Icons.arrow_forward_ios,
              color: _themeData.onboardingTheme.iconColor,
            ),
            onPressed: onNextClicked,
          ),
        ],
      ),
    );
  }
}
