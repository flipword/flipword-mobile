import 'package:flutter/material.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:onboarding/onboarding.dart';

import 'generic_on_boarding_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key, required this.onClose}) : super(key: key);

  final VoidCallback onClose;

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final onBoardingPagesList = [
      PageModel(
        widget: GenericOnBoardingPage(
          title: t.choose_language,
          description: t.choose_language_desc,
          imagePath: 'assets/earth.png',
        ),
      ),
      PageModel(
        widget: GenericOnBoardingPage(
          title: t.create_word_list,
          description: t.create_word_list_desc,
          imagePath: 'assets/list.png',
          moreInfo: t.create_word_list_more_info,
        ),
      ),
      PageModel(
        widget: GenericOnBoardingPage(
          title: t.flipword_title,
          description: t.flipword_desc,
          imagePath: 'assets/onboarding-logo.png',
        ),
      ),
    ];

    return Onboarding(
      background: Theme.of(context).scaffoldBackgroundColor,
      proceedButtonStyle: ProceedButtonStyle(
        proceedButtonColor: Theme.of(context).primaryColor,
        proceedpButtonText: Text(t.start,
            style:
                const TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600)),
        proceedButtonRoute: (context) {
          widget.onClose();
        },
      ),
      pages: onBoardingPagesList,
      isSkippable: false,
      indicator: Indicator(
          activeIndicator:
              ActiveIndicator(color: Theme.of(context).primaryColor),
          closedIndicator:
              ClosedIndicator(color: Theme.of(context).primaryColor),
          indicatorDesign: IndicatorDesign.polygon(
              polygonDesign: PolygonDesign(
            polygon: DesignType.polygon_circle,
          ))),
    );
  }
}
