import 'package:basearch/src/features/onboarding/presentation/widget/onboarding.dart';
import 'package:basearch/src/features/onboarding/presentation/widget/page_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/onboarding.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<PageOnboarding> _pageList = [
    PageOnboarding(
      image: SvgPicture.asset('lib/assets/images/onboarding1.svg'),
      title: 'onboarding-title-1'.i18n(),
      subtitle: 'onboarding-subtitle-1'.i18n(),
    ),
    PageOnboarding(
      imageLeft: SvgPicture.asset('lib/assets/images/orchild.svg'),
      image: SvgPicture.asset('lib/assets/images/onboarding2.svg'),
      title: 'onboarding-title-2'.i18n(),
      subtitle: 'onboarding-subtitle-2'.i18n(),
    ),
    PageOnboarding(
      imageLeft: SvgPicture.asset('lib/assets/images/orchild1.svg'),
      imageRigth: SvgPicture.asset('lib/assets/images/orchild2.svg'),
      image: SvgPicture.asset('lib/assets/images/onboarding3.svg'),
      title: 'onboarding-title-3'.i18n(),
      subtitle: 'onboarding-subtitle-3'.i18n(),
    ),
  ];

  static const String _showOnboardingKey = "show-onboarding";
  bool _showOnboarding = false;

  _OnBoardingPageState() {
    _checkOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: _showOnboarding
            ? Onboarding(
                pageList: _pageList,
                onFinish: () => _finish(),
              )
            : Container(),
      ),
    );
  }

  _checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final showOnboarding = prefs.getBool(_showOnboardingKey) ?? true;
    if (showOnboarding) {
      setState(() {
        _showOnboarding = showOnboarding;
      });
    } else {
      Modular.to.navigate('/auth/');
    }
  }

  _finish() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showOnboardingKey, false);
    Modular.to.navigate('/auth/');
  }
}
