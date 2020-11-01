import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;


class ListWordPage extends StatefulWidget {
  static const String routeName = '/list';

  @override
  _ListWordPageState createState() => _ListWordPageState();
}

class _ListWordPageState extends State<ListWordPage> {
  CardListStore _cardList;
  @override
  void initState() {
    _cardList = Provider.of<CardListStore>(context, listen: false);
    if(_cardList.list.value.isEmpty) {
      _cardList.fetchCard();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final future = _cardList.list;
    Widget _widgetDisplayed;
    return Observer(
        builder: (_) {
          int _extraindex = -2;
          switch (future.status) {
            case FutureStatus.pending:
              _widgetDisplayed = const Center(
                child: CircularProgressIndicator(),
              );
              break;
            case FutureStatus.fulfilled:
              final List<entity.Card> cards = future.result as List<entity.Card>;
              _widgetDisplayed = Scaffold(
                  body: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: (future.value.length % 2 == 0 ? future.value.length / 2 : future.value.length ~/ 2 + 1).toInt(),
                      itemBuilder: (context, index) {
                        _extraindex += 2;
                        return Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CardWord(
                                      nativeWord: cards[_extraindex].nativeWord.word,
                                      foreignWord: cards[_extraindex].foreignWord.word
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: _extraindex + 1 < future.value.length ? CardWord(
                                      nativeWord: cards[_extraindex+1].nativeWord.word,
                                      foreignWord: cards[_extraindex+1].foreignWord.word
                                      ) : const SizedBox()
                                ),
                                const SizedBox(width: 10)
                              ],
                            )
                        );
                      },
                    ),
                  )
              );
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
        }
    );
  }
  Future _refresh() => _cardList.fetchCard();
}
