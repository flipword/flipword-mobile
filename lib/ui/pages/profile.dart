import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_offline.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_online.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String googleLogoAsset = 'assets/google-logo.svg';
  final String appleLogoAsset = 'assets/apple-logo.svg';
  late ProfilStore _profilStore;
  late CardListStore _cardListStore;
  late InterfaceStore _interfaceStore;
  late SettingStore _settingStore;

  String? userName;
  FileImage? image;
  bool? conection;
  String? effet;

  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Widget _widgetDisplayed;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(body: Observer(
      builder: (context) {
        switch (_profilStore.currentProfile.status) {
          case FutureStatus.pending:
            _widgetDisplayed = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case FutureStatus.fulfilled:
            if (_profilStore.currentProfile.value!.isConnected) {
              _widgetDisplayed = Center(
                  child: Column(children: [
                SizedBox(height: height / 10),
                const ProfileOnline(),
                RaisedButton(
                  textTheme: Theme.of(context).buttonTheme.textTheme,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed:
                      _interfaceStore.overlayIsDisplayed.value ? null : _logout,
                  child: Text(t.logout),
                )
              ]));
            } else {
              _widgetDisplayed = Center(
                  child: Column(children: [
                const ProfileOffline(),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                RaisedButton(
                    textTheme: Theme.of(context).buttonTheme.textTheme,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () => _login(SignInMethod.GOOGLE),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(googleLogoAsset,
                            height: 25, width: 25),
                        const SizedBox(width: 10),
                        Text(t.login_google)
                      ],
                    )),
                const SizedBox(height: 10),
                if (defaultTargetPlatform != TargetPlatform.android)
                  RaisedButton(
                      textTheme: Theme.of(context).buttonTheme.textTheme,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () => _login(SignInMethod.APPLE),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(appleLogoAsset,
                              height: 25, width: 25),
                          const SizedBox(width: 10),
                          Text(t.login_apple)
                        ],
                      ))
                else
                  const SizedBox(),
              ]));
            }
            break;
          case FutureStatus.rejected:
            _widgetDisplayed = const Center(
                child: Text(
              'Fail',
              textAlign: TextAlign.center,
            ));
            break;
        }
        return _widgetDisplayed;
      },
    ));
  }

  void _login(SignInMethod signInMethod) {
    _profilStore
        .login(signInMethod)
        .then((value) => _settingStore.initLanguages());
  }

  void _logout() {
    _profilStore.logout().then((value) => _cardListStore.fetchCard());
  }
}
