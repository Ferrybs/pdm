import 'dart:ui';

import 'package:basearch/src/features/onboarding/presentation/widget/onboarding_navigation.dart';
import 'package:basearch/src/features/onboarding/presentation/widget/page_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'onboarding_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    Key? key,
    required this.pageList,
    this.onFinish,
  }) : super(key: key);

  final List<PageOnboarding> pageList;
  final Function? onFinish;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [...widget.pageList],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardingNavigation(
              onPreviousClicked: _currentPage == 0
                  ? null
                  : () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
              onNextClicked: _currentPage != widget.pageList.length - 1
                  ? null
                  : () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: _currentPage != widget.pageList.length - 1
                        ? null
                        : ElevatedButton(
                            child: Text('login'.i18n().toUpperCase()),
                            onPressed: () => widget.onFinish!(),
                          ),
                  ),
                ),
                OnboardingPageIndicator(
                  controller: _controller,
                  count: widget.pageList.length,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
