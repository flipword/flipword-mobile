import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/layouts/main_layout.dart';
import 'package:flutter_flip_card/ui/layouts/start_layout.dart';
import 'package:flutter_flip_card/ui/themes/dark_theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'ui/themes/light_theme.dart';



Future<dynamic> main() async {

  const env =  String.fromEnvironment('ENV', defaultValue: 'prod');
  switch(env){
    case 'dev':
      Constanants.setEnvironement(Environement.DEV);
      break;
    case 'staging':
      Constanants.setEnvironement(Environement.STAGING);
      break;
    case 'prod':
      Constanants.setEnvironement(Environement.PROD);
      break;
  }
  runApp(DevicePreview(builder: (context) => MyApp(), enabled: Constanants.isDebuggable!,));
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  late CardListStore _cardListStore;
  late ProfilStore _profilStore;
  late InterfaceStore _interfaceStore;
  late SettingStore _settingStore;


  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(Constanants.deviceOrientatuon!);
    return FutureBuilder(
          future: _initApp(context),
          builder: (context, snapshot) {
              return MultiProvider(
                  providers: [
                    Provider<CardListStore?>(create: (_) => _cardListStore),
                    Provider<ProfilStore?>(create: (_) => _profilStore),
                    Provider<InterfaceStore?>(create: (_) => _interfaceStore),
                    Provider<SettingStore?>(create: (_) => _settingStore)
                  ],
                child: MaterialApp(
                    title: 'FlipWord',
                    // Initialize media query for preview builder
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
                    theme: LightTheme.defaultTheme,
                    darkTheme: DarkTheme.defaultTheme,
                    home: snapshot.connectionState == ConnectionState.done ? snapshot.hasError ? Scaffold(
                        body: Center(
                          child: Column(children: [
                            const Icon(Icons.warning_amber_outlined),
                            Text('Error at application startup: ${snapshot.error} | StackTrace: ${snapshot.stackTrace.toString()}')
                          ]),
                        )) : Observer(builder: (context) {
                          if(_profilStore.currentProfile.status == FutureStatus.pending){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if(_profilStore.currentProfile.value!.hasDidMainOnBoarding){
                              _cardListStore.fetchCard();
                              return const MainLayout();
                            } else {
                              return const StartLayout();
                            }
                          }
                    }) : const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ),
              );
            }
    );
  }

  Future<void> _initApp(context) async{
    await Firebase.initializeApp();
    _profilStore = ProfilStore();
    await _profilStore.refresh();
    _settingStore = SettingStore();
    await _settingStore.initLanguages();
    _cardListStore = CardListStore();
    _interfaceStore = InterfaceStore();

  }
}
