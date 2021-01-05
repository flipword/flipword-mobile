import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_offline.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_online.dart';
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
  CardListStore _cardListStore;
  InterfaceStore _interfaceStore;

  String userName;
  FileImage image;
  bool conection;
  String effet;

  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _widgetDisplayed;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(body: Observer(
      builder: (_) {
        switch (_profilStore.courantProfil.status) {
          case FutureStatus.pending:
            _widgetDisplayed = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case FutureStatus.fulfilled:
            if (_profilStore.courantProfil.value.isConnecter) {
              _widgetDisplayed = Scaffold(
                  body: Column(children: [
                SizedBox(height: height / 10),
                const ProfileOnline(),
                RaisedButton(
                  textTheme: Theme.of(context).buttonTheme.textTheme,
                  color: Theme.of(context).primaryColor,
                  onPressed:
                      _interfaceStore.overlayIsDisplayed.value ? null : _logout,
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
                    onPressed: _login,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_circle),
                        const Text('Login or Sing in with Google')
                      ],
                    ))
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

  void _login() {
    _profilStore.login().then((value) => _cardListStore.fetchCard());
  }

  void _logout() {
    _profilStore.logout().then((value) => _cardListStore.fetchCard());
  }
}
