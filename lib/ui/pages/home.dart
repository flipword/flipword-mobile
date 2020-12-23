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
    if (_cardListStore.list.status == FutureStatus.fulfilled) {
      if (_cardListStore.list.value.isEmpty) {
        _cardListStore.fetchCard();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final future = _cardListStore.list;
    Widget _widgetDisplayed;
    return Observer(
      builder: (_) {
        switch (future.status) {
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
                      Icon(Icons.warning_amber_outlined),
                      Text('An error occured : the connection was rejected')
                ]));
            break;
          case FutureStatus.fulfilled:
            _widgetDisplayed =
                Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      CardGuessWidget(),
                      /*if (_cardListStore.found.value)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          SquareButton(
                              onPressed: () {_cardListStore.actionOnCard();},
                              icon: const Icon(Icons.check, size: 30),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                              width: 45,
                              height: 45,
                            ), SquareButton(
                              onPressed: () {_cardListStore.actionOnCard();},
                              icon: const Icon(Icons.clear, size: 30),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                              width: 45,
                              height: 45,
                            )
                          ],
                        )*/
                      if (!_cardListStore.found.value)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      if (_cardListStore.found.value && _cardListStore.isFinished)
                        SquareButton(
                          onPressed: () {_cardListStore.resetIndex();},
                          icon: const Icon(Icons.restore, size: 30),
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                          width: 45,
                          height: 45,
                        )
                       else
                      SquareButton(
                        onPressed: () {_cardListStore.actionOnCard();},
                        icon: const Icon(Icons.open_in_new, size: 30),
                        backgroundColor: Theme
                            .of(context)
                            .primaryColorDark,
                        width: 45,
                        height: 45,
                      )
                        ])
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
