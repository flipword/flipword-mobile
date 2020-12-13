import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_offline.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_online.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilStore _profilStore;
  final firebaseAuthService = AuthService.instance;

  String userName;
  FileImage image;
  bool conection;
  String effet;

  @override
  Widget build(BuildContext context) {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    Widget _widgetDisplayed;
    return Scaffold(body: Observer(
      builder: (_) {
        if (_profilStore.courantProfil.isConnecter) {
          _widgetDisplayed = Scaffold(
              body: Column(children: [
            ProfileOnline(),
            RaisedButton(
              textTheme: Theme.of(context).buttonTheme.textTheme,
              color: Theme.of(context).primaryColor,
              onPressed: _profilStore.logout,
              child: const Text('Logout'),
            )
          ]));
        } else {
          _widgetDisplayed = Scaffold(
              body: Column(children: [
            ProfileOffline(),
                RaisedButton(
                  textTheme: Theme.of(context).buttonTheme.textTheme,
                  color: Theme.of(context).primaryColor,
                  onPressed: _profilStore.login,
                  child: const Text('Login or Sing in with Google'),
                )
          ]));
        }
        return _widgetDisplayed;
      },
    ));
  }
}
