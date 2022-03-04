import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/router/router_app.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/pages/home.dart';
import 'package:flutter_flip_card/ui/pages/list_word.dart';
import 'package:flutter_flip_card/ui/pages/profile.dart';
import 'package:flutter_flip_card/ui/pages/setting.dart';
import 'package:flutter_flip_card/ui/widgets/language/choose_language.dart';
import 'package:flutter_flip_card/ui/widgets/on_boarding/on_boarding.dart';
import 'package:flutter_flip_card/ui/widgets/utils/bottom_bar/fab_bottom_bar.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/add_word.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late CardListStore _cardListStore;
  late InterfaceStore _interfaceStore;
  late ProfilStore _profilStore;
  bool displayOverlay = false;
  LanguageService languageService = LanguageService.instance;
  double? dragOffset;
  @override
  void initState() {
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) {
          Overlay.of(context)!.insert(_createOverlayEntry());
          if(!_profilStore.currentProfile.value!.hasChooseLanguage){
            _showChooseLanguageModal();
          }
        });
    dragOffset = 50;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: _closeOverlay,
          onVerticalDragUpdate: (defaultTargetPlatform == TargetPlatform.iOS) || (defaultTargetPlatform == TargetPlatform.android) ? _updateOverlay : null,
          onVerticalDragEnd: (defaultTargetPlatform == TargetPlatform.iOS) || (defaultTargetPlatform == TargetPlatform.android) ? _onDragEnd : null,
          child: _buildBody(context),
        ),
        floatingActionButton: SquareButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _onFloatingButtonTapped
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNavigationBar(context));
  }

  Widget _buildBody(context) {
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: RouterApp.generateRoute);
  }

  Widget _buildBottomNavigationBar(BuildContext context) => FABBottomAppBar(
        iconColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(
              iconData: Icons.home, routeName: HomePage.routeName),
          FABBottomAppBarItem(
              iconData: Icons.list, routeName: ListWordPage.routeName),
          FABBottomAppBarItem(
              iconData: Icons.settings, routeName: SettingPage.routeName),
          FABBottomAppBarItem(
              iconData: Icons.person_outline, routeName: ProfilePage.routeName),
        ],
      );

  void _onItemTapped(String routeName) {
    _closeOverlay();
    if (_interfaceStore.currentRoute.value == null ||
        _interfaceStore.currentRoute.value != routeName) {
      setState(() {
        _interfaceStore.setCurrentRoute(routeName);
        navigatorKey.currentState!.pushReplacementNamed(routeName);
      });
    }
  }

  void _onFloatingButtonTapped() {
    _openOverlay();
  }

  void _closeOverlay() {
    Overlay.of(context)!.setState(() {
      _interfaceStore
        ..closeOverlay()
        ..resetAddingPopupOffset();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _openOverlay() {
    Overlay.of(context)!.setState(() {
      _interfaceStore
        ..openOverlay()
        ..resetAddingPopupOffset();
    });
  }

  void _updateOverlay(DragUpdateDetails dragOffset) {
    if (_interfaceStore.overlayIsDisplayed.value) {
      Overlay.of(context)!.setState(() {
        _interfaceStore.updateAddingPopupOffset(dragOffset.delta.dy);
      });
    }
  }

  void _onDragEnd(DragEndDetails dragEnd) {
    if (dragEnd.velocity.pixelsPerSecond.dy < 0) {
      _closeOverlay();
    } else {
      _openOverlay();
    }
  }

  OverlayEntry _createOverlayEntry() {
    final screenHeight = MediaQuery.of(context).size.height;
    return OverlayEntry(
        builder: (context) => AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              top: _interfaceStore.overlayIsDisplayed.value
                  ? _interfaceStore.addingPopupOffset.value
                  : -screenHeight,
              child: AddWord(onDragUp: _updateOverlay, onDragEnd: _onDragEnd),
            ));
  }

  void _showChooseLanguageModal() {
    BuildContext dialogContext;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)), //this right here
            child: ChooseLanguage(onClose: () {
              Navigator.of(dialogContext).pop();
              _cardListStore.fetchCard();
            }),
          );
        });
  }
}
