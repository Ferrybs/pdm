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
    OnboardingThemeData _theme = Theme.of(context).onboardingTheme;
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
                child: Container(child: image),
              ),
              Expanded(
                flex: 3,
                child: createText(
                  title,
                  _theme.titleStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: createText(
                  subtitle,
                  _theme.subtitleStyle,
                ),
              ),
            ],
          ),
        ),
        createTopImages(),
      ],
    );
  }

  Container createText(String text, TextStyle? textStyle) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }

  Container createTopImages() {
    return Container(
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
    );
  }
}
