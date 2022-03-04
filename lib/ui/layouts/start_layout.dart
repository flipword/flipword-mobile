import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/widgets/language/choose_language.dart';
import 'package:flutter_flip_card/ui/widgets/on_boarding/on_boarding.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class StartLayout extends StatefulWidget {
  const StartLayout({Key? key}) : super(key: key);

  @override
  StartLayoutState createState() => StartLayoutState();
}

class StartLayoutState extends State<StartLayout> {
  late ProfilStore _profilStore;
  bool displayOverlay = false;
  int onBoardingStep = 1;

  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget _widgetDisplayed;
    switch(onBoardingStep){
      case 1:
        _widgetDisplayed = Center(child: ChooseLanguage(onClose: () {
          setState(() {
            onBoardingStep += 1;
          });
        }));
        break;
      case 2:
        _widgetDisplayed = const OnBoarding();
        break;
    }
    return Scaffold(body: _widgetDisplayed);
  }

}
