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
  bool _found = false;
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

  void increaseCounter() {
    setState(() {
      _found = false;
      if (_cardListStore.isFinished) {
      } else {
        _cardListStore.curentIndex =
            ObservableFuture.value(_cardListStore.curentIndex.value + 1);
      }
    });
  }

  void resetIndex() {
    setState(() {
      _cardListStore.curentIndex = ObservableFuture.value(0);
      _found = false;
    });
  }

  void discoverWord() {
    setState(() {
      _found = true;
    });
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
            break;
          case FutureStatus.fulfilled:
            _widgetDisplayed =
                Scaffold(
                body: Column(
                    children: [
                      Text(
                          _cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word,
                      ),
                      if (!_found)
                        IconButton(
                            icon: Icon(Icons.question_answer_outlined),
                            onPressed: () {
                              discoverWord();
                            }),
                      Text(_cardListStore.curentIndex.value.toString()),
                      Text((() {
                        if (_found && !_cardListStore.isFinished) {
                          return _cardListStore.list.result[_cardListStore.curentIndex.value].nativeWord.word;
                        } else {
                          return "???";
                        }
                      })()),
                      if (_found && !_cardListStore.isFinished)
                        IconButton(
                            icon: Icon(Icons.arrow_forward_rounded),
                            onPressed: () {
                              increaseCounter();
                            }),
                      if (_cardListStore.isFinished)
                        IconButton(
                            icon: Icon(Icons.restore),
                            onPressed: () {
                              resetIndex();
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

    /*return ;*/
  }
}
