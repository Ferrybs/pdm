import 'package:basearch/src/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingPageIndicator({
    Key? key,
    required this.controller,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      height: 70,
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: WormEffect(
          dotHeight: 14,
          dotWidth: 14,
          spacing: 16,
          dotColor: _theme.onboardingTheme.dotColor,
          activeDotColor: _theme.onboardingTheme.activeDotColor,
        ),
        onDotClicked: (index) => controller.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn),
      ),
    );
  }
}
