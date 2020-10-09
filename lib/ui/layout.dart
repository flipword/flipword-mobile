import 'package:flutter/material.dart';
import 'package:flutter_flip_card/router.dart';
import 'package:flutter_flip_card/ui/components/bottom_bar/fab_bottom_bar.dart';
import 'package:flutter_flip_card/ui/components/button/square_button.dart';
import 'package:flutter_flip_card/ui/pages/add_word.dart';

class Layout extends StatefulWidget {

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin{

  var navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: _buildBody(),
      floatingActionButton: new SquareButton(
        icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
        ),
        backgroundColor: Color.fromARGB(255, 94, 177, 191),
        onPressed: () {navigatorKey.currentState.pushNamed(AddWordPage.routeName);}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavigationBar(context),
    ),
  );

  Widget _buildBody() =>
      MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: (route) => Router.generateRoute(route)
      );

  Widget _buildBottomNavigationBar(context) => FABBottomAppBar(
    color: Colors.black,
    backgroundColor: Colors.white,
    selectedColor: Color.fromARGB(255, 247, 239, 153),
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