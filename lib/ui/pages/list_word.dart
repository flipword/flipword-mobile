import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/data/entities/word.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:flutter_flip_card/ui/widgets/words/detail_word.dart';
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
  final CardService _cardService = CardService.instance;
  final ToastService _toastService = ToastService.instance;

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
    final screenSize = MediaQuery.of(context).size;
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
              final List<entity.CardEntity> cards = future.result as List<entity.CardEntity>;
              _widgetDisplayed = Scaffold(
                  body: RefreshIndicator(
                    onRefresh: _refresh,
                    child: GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: _calculElementDisplay(screenSize),
                        crossAxisCount: 2,
                        semanticChildCount: 10,
                        children: List.generate(future.value.length, (index) =>
                          GestureDetector(
                            onTap: () => {
                              _showModal(cards[index])
                            },
                            child: CardWord(
                                nativeWord: cards[index].nativeWord.word,
                                foreignWord: cards[index].foreignWord.word
                            ),
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


  double _calculElementDisplay(screenSize){
    if(screenSize.height > 1000) {
      return 3;
    }
    else if(screenSize.height > 800) {
      return 2.5;
    }
    else if(screenSize.height > 600) {
      return 2;
    }
    else{
      return 1.5;
    }
  }

  void _showModal(CardEntity card) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20)), //this right here
            child: DetailWord(card: card, onDelete: _deleteWord)
        )
    );
  }

  void _deleteWord(String id){
    _cardService.deleteCard(id)
        .then((value) => {_toastService.toastValidate('Card delete with success')})
        .catchError((onError) => {_toastService.toastError('Error on deleting card')})
        .whenComplete(() => Navigator.of(context, rootNavigator: true).pop());

  }
}
