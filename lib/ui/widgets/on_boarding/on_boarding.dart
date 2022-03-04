import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:onboarding/onboarding.dart';
import 'package:provider/provider.dart';

import 'generic_on_boarding_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late ProfilStore _profilStore;

  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    super.initState();
  }
  final onBoardingPagesList = [
    PageModel(
      widget: GenericOnBoardingPage(
        title: 'Choose a language',
        description: 'Choose a language you want to learn.',
        imagePath: 'assets/earth.png',
      ),
    ),
    PageModel(
      widget: GenericOnBoardingPage(
        title: 'Create word list',
        description: 'Create your own personalized list by adding unknow words that met daily.',
        imagePath: 'assets/list.png',
        moreInfo: '*Automatic translation and Chrome extension is available to facilate this process.',
      ),
    ),
    PageModel(
      widget: GenericOnBoardingPage(
        title: 'And...Flipword!',
        description: 'Learn your word list thanks to flippable cards.',
        imagePath: 'assets/onboarding-logo.png',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      background: Theme.of(context).scaffoldBackgroundColor,
      proceedButtonStyle: ProceedButtonStyle(
        proceedButtonColor: Theme.of(context).primaryColor,
        proceedpButtonText: const Text(
            'Start',
            style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600,)
        ),
        proceedButtonRoute: (context) {
          _profilStore.changeMainOnBoardingStatus();
        },
      ),
      pages: onBoardingPagesList,
      isSkippable: false,
      indicator: Indicator(
          activeIndicator: ActiveIndicator(color: Theme.of(context).primaryColor),
          closedIndicator: ClosedIndicator(color: Theme.of(context).primaryColor),
          indicatorDesign: IndicatorDesign.polygon(
              polygonDesign: PolygonDesign(
                polygon: DesignType.polygon_circle,
              )
          )
      ),
    );
  }
}