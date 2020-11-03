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
    final screenSize = MediaQuery.of(context).size.width;
    Widget _widgetDisplayed;
    return Observer(
        builder: (_) {
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
                    child: GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: ((screenSize-50)/2) / 80,
                        crossAxisCount: 2,
                        semanticChildCount: 10,
                        children: List.generate(future.value.length, (index) => CardWord(
                              nativeWord: cards[index].nativeWord.word,
                              foreignWord: cards[index].foreignWord.word
                          )
                        )
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
