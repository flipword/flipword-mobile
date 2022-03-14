import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/language/choose_language.dart';
import 'package:flutter_flip_card/ui/widgets/on_boarding/on_boarding.dart';
import 'package:provider/provider.dart';

class StartLayout extends StatefulWidget {
  const StartLayout({Key? key}) : super(key: key);

  @override
  StartLayoutState createState() => StartLayoutState();
}

class StartLayoutState extends State<StartLayout> {
  late ProfilStore _profilStore;
  late SettingStore _settingStore;

  late Language nativeLanguage;
  late Language foreignLanguage;
  bool displayOverlay = false;
  int onBoardingStep = 1;

  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget _widgetDisplayed;
    switch (onBoardingStep) {
      case 1:
        _widgetDisplayed = Center(
            child: ChooseLanguage(onPick: (language) {
          nativeLanguage = language;
          _saveNativeLanguage();
        }, onClose: () {
          setState(() {
            onBoardingStep += 1;
          });
        }));
        break;
      case 2:
        _widgetDisplayed = OnBoarding(onClose: () {
          setState(() {
            onBoardingStep += 1;
          });
        });
        break;
      case 3:
        _widgetDisplayed = Center(
            child: ChooseLanguage(
                pickNative: false,
                onPick: (language) {
                  foreignLanguage = language;
                },
                onClose: _savePicks));
        break;
    }
    return Scaffold(body: _widgetDisplayed);
  }

  Future<void> _savePicks() async {
    await Future.wait([
      _settingStore.updateForeignLanguage(foreignLanguage),
      _profilStore.changeMainOnBoardingStatus()
    ]);
    await _profilStore.refresh();
  }

  Future<void> _saveNativeLanguage() async {
    await _settingStore.updateNativeLanguage(nativeLanguage);
  }
}
