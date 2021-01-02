import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_guess_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CardListStore _cardListStore;

  @override
  void initState() {
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _widgetDisplayed;
    return Observer(
      builder: (_) {
        switch (_cardListStore.list.status) {
          case FutureStatus.pending:
            _widgetDisplayed = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case FutureStatus.rejected:
            // TODO: Handle this case.
            _widgetDisplayed =
                Scaffold(
                  body: Column(
                    children: [
                      const Icon(Icons.warning_amber_outlined),
                      const Text('An error occured : the connection was rejected')
                ]));
            break;
          case FutureStatus.fulfilled:
            _widgetDisplayed =
                Scaffold(
                  resizeToAvoidBottomPadding: false,
                body: Center(
                  child: Column(
                    children: [
                        CardGuessWidget()

                    ]
                ))
            );
            break;
        }
        return _widgetDisplayed;
      }

    );
  }
}
