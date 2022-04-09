import 'package:basearch/src/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageOnboarding extends StatelessWidget {
  const PageOnboarding({
    Key? key,
    this.imageLeft,
    this.imageRigth,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final SvgPicture? imageLeft;
  final SvgPicture? imageRigth;
  final SvgPicture image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 140.0, bottom: 170.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  child: image,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: _themeData.onboardingTheme.titleStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: _themeData.onboardingTheme.subtitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 90,
          margin: const EdgeInsets.only(top: 80.0),
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: imageLeft,
              ),
              Container(
                child: imageRigth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
