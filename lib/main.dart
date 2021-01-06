import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/layouts/layout.dart';
import 'package:flutter_flip_card/ui/themes/dark_theme.dart';
import 'package:provider/provider.dart';
import 'ui/themes/light_theme.dart';



void main()  {

  const env =  String.fromEnvironment('ENV', defaultValue: 'dev');
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

  runApp(DevicePreview(builder: (context) => MyApp(), enabled: Constanants.isDebuggable,));
}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  CardListStore _cardListStore;
  ProfilStore _profilStore;
  InterfaceStore _interfaceStore;


  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(Constanants.deviceOrientatuon);

    return FutureBuilder(
          future: _initApp(context),
          builder: (context, snapshot) {
            if (snapshot.hasError || (snapshot.connectionState == ConnectionState.done)) {
              return MultiProvider(
                  providers: [
                    Provider<CardListStore>(create: (_) => _cardListStore),
                    Provider<ProfilStore>(create: (_) => _profilStore),
                    Provider<InterfaceStore>(create: (_) => _interfaceStore)
                  ],
                child: MaterialApp(
                    title: 'FlipWord',
                    // Initialize media query for preview builder
                    locale: DevicePreview.of(context).locale,
                    builder: DevicePreview.appBuilder,
                    theme: LightTheme.defaultTheme,
                    darkTheme: DarkTheme.defaultTheme,
                    home: Layout()
                ),
              );
            }
            // Todo: voir pour enlever cette material app(nécessaire pour le scafold sinon erreur)
            return MaterialApp(
                title: 'LoadingScreen',
                locale: DevicePreview.of(context).locale,
                builder: DevicePreview.appBuilder,
                theme: LightTheme.defaultTheme,
                darkTheme: DarkTheme.defaultTheme,
                home: const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            );
          },
    );
  }

  Future<void> _initApp(context) async{
    await Firebase.initializeApp();
    _cardListStore = CardListStore();
    _profilStore = ProfilStore();
    _interfaceStore = InterfaceStore();
    await _profilStore.loadProfil();
    await _cardListStore.fetchCard();
  }
}
