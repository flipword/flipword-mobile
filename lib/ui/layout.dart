import 'package:flutter/material.dart';
import 'package:flutter_flip_card/router/router.dart';
import 'package:flutter_flip_card/ui/components/bottom_bar/fab_bottom_bar.dart';
import 'package:flutter_flip_card/ui/components/button/square_button.dart';
import 'package:flutter_flip_card/ui/pages/add_word.dart';
import 'package:flutter_flip_card/ui/themes/theme.dart';

class Layout extends StatefulWidget {

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin{

  var navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: _buildBody(),
      floatingActionButton: new SquareButton(
        icon: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
            size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {navigatorKey.currentState.pushNamed(AddWordPage.routeName);}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavigationBar(context)
  );

  Widget _buildBody() =>
      MaterialApp(
          navigatorKey: navigatorKey,
          theme: MyTheme.defaultTheme,
          onGenerateRoute: (route) => Router.generateRoute(route)
      );

  Widget _buildBottomNavigationBar(context) => FABBottomAppBar(
    iconColor: Theme.of(context).iconTheme.color,
    backgroundColor: Theme.of(context).bottomAppBarColor,
    notchedShape: CircularNotchedRectangle(),
    onTabSelected: _onItemTapped,
    items: [
      FABBottomAppBarItem(iconData: Icons.filter_none),
      FABBottomAppBarItem(iconData: Icons.person_outline),
    ],
  );

  void _onItemTapped(int routeIndex) {
    setState(() {
      _selectedIndex = routeIndex;
      navigatorKey.currentState.pushNamed(Router.routes[routeIndex]);
    });
  }
}