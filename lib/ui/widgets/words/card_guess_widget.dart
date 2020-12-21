import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

/*
* Ce sera le widget sécifique our l'affichage du mot
*
* */

class CardGuessWidget extends StatefulWidget {
  @override
  _CardGuessWidgetState createState() => _CardGuessWidgetState();
}

class _CardGuessWidgetState extends State<CardGuessWidget> {
  CardListStore _cardListStore;
  bool isFound = false;

  static String wordFind = 'le mot a deviner';
  static const String wordFound = 'le mot trouvé';

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

  void revealWord() {
    setState(() {
      isFound = !isFound;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _widgetDisplayed;
    return Observer(
        builder: (_) {
          if (_cardListStore.found.value) {
          _widgetDisplayed = Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12)
              ),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("foreign 2: " +
                        _cardListStore.list.result[_cardListStore
                            .curentIndex.value].foreignWord.word, style: TextStyle(
                        fontSize: 26,

                        fontWeight: FontWeight.w400
                    )),
                    //Text(_cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word, textAlign: TextAlign.left),
                  ]
              )
          );
          }
            else {
              _widgetDisplayed = Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12)
                  ),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("native 2 : " +
                            _cardListStore.list.result[_cardListStore
                                .curentIndex.value].nativeWord.word, style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400
                        )),
                        //Text(_cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word, textAlign: TextAlign.left),
                      ]
                  )
              );
            }
          return _widgetDisplayed;
        });
  }
}