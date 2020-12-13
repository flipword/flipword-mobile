import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
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

  var listCard = null;
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
                      Text("An error occured : the connection was rejected")
                ]));
            break;
          case FutureStatus.fulfilled:
            _widgetDisplayed =
                Scaffold(
                body: Column(
                    children: [
                      Text(
                          _cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word,
                      ),
                      if (!_cardListStore.found.value)
                        IconButton(
                            icon: Icon(Icons.question_answer_outlined),
                            onPressed: () {
                              _cardListStore.actionOnCard();
                            }),
                      Text(_cardListStore.curentIndex.value.toString()),
                      Text((() {
                        if (_cardListStore.found.value) {
                          return _cardListStore.list.result[_cardListStore.curentIndex.value].nativeWord.word;
                        } else {
                          return "???";
                        }
                      })()),
                      if (!_cardListStore.isFinished  && _cardListStore.found.value )
                        IconButton(
                            icon: Icon(Icons.arrow_forward_rounded),
                            onPressed: () {
                              _cardListStore.actionOnCard();
                            }),
                      if (_cardListStore.isFinished  && _cardListStore.found.value)
                        IconButton(
                            icon: Icon(Icons.restore),
                            onPressed: () {
                              _cardListStore.resetIndex();
                            }
                        )
                    ]
                )
            );
            break;
        }
        return _widgetDisplayed;
      }
    );
  }
}
