import 'package:flutter/material.dart';
import 'package:flutter_flip_card/router/router_app.dart';
import 'package:flutter_flip_card/service/language_service.dart';
import 'package:flutter_flip_card/ui/components/add_word.dart';
import 'package:flutter_flip_card/ui/components/bottom_bar/fab_bottom_bar.dart';
import 'package:flutter_flip_card/ui/components/button/square_button.dart';
import 'package:flutter_flip_card/ui/pages/home.dart';
import 'package:flutter_flip_card/ui/pages/list_word.dart';
import 'package:flutter_flip_card/ui/pages/profile.dart';
import 'package:flutter_flip_card/ui/pages/setting.dart';

class Layout extends StatefulWidget {

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin{
  OverlayEntry _overlayEntry;

  var displayOverlay = false;
  var navigatorKey = GlobalKey<NavigatorState>();
  LanguageService languageService = LanguageService.instance;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
      floatingActionButton: new SquareButton(
        icon: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
            size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {_onFloatingButtonTapped();}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavigationBar(context)
  );

  Widget _buildBody(context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: HomePage.routeName,
      onGenerateRoute: (route) => RouterApp.generateRoute(route)
    );
  }
  
  Widget _buildBottomNavigationBar(context) => FABBottomAppBar(
    iconColor: Theme.of(context).iconTheme.color,
    backgroundColor: Theme.of(context).bottomAppBarColor,
    selectedColor: Theme.of(context).accentColor,
    notchedShape: CircularNotchedRectangle(),
    onTabSelected: _onItemTapped,
    items: [
      FABBottomAppBarItem(iconData: Icons.home, routeName: HomePage.routeName),
      FABBottomAppBarItem(iconData: Icons.list , routeName: ListWordPage.routeName),
      FABBottomAppBarItem(iconData: Icons.settings, routeName: SettingPage.routeName),
      FABBottomAppBarItem(iconData: Icons.person_outline, routeName: ProfilePage.routeName),
    ],
  );

  void _onItemTapped(String routeName) {
    if(displayOverlay) {
      this._overlayEntry.remove();
      this.displayOverlay = false;
    }
    setState(() {
      navigatorKey.currentState.pushNamed(routeName);
    });
  }

  void _onFloatingButtonTapped(){
    if(!this.displayOverlay) {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
      this.displayOverlay = true;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => AddWord()
    );
  }
}