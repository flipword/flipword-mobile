import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
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
          //here we print the word to find
          if (!_cardListStore.found.value) {
          _widgetDisplayed =
              Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height/3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height/2,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              width: 8,
                            ),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child:
                    Text("foreign : " +
                        _cardListStore.list.result[_cardListStore
                            .curentIndex.value].foreignWord.word, style: TextStyle(
                        fontSize: 26,

                        fontWeight: FontWeight.w400
                    ))),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SquareButton(
                      onPressed: () {_cardListStore.actionOnCard();},
                      icon: const Icon(Icons.open_in_new, size: 30),
                      backgroundColor: Theme
                          .of(context)
                          .primaryColorDark,
                      width: 45,
                      height: 45,
                    ),
            SquareButton(
              onPressed: () {_cardListStore.actionOnCard();},
              icon: const Icon(Icons.open_in_new, size: 30),
              backgroundColor: Theme
                  .of(context)
                  .primaryColorDark,
              width: 45,
              height: 45,
            )
                    //Text(_cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word, textAlign: TextAlign.left),
                  ]
              )
                  ])
          );
          }
            else {
              //here we display the word found
              _widgetDisplayed = Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width  / 2,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:
                        Text("native : " +
                            _cardListStore.list.result[_cardListStore
                                .curentIndex.value].nativeWord.word, style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400
                        ))),
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
                        )
                        //Text(_cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word, textAlign: TextAlign.left),
                      ]
                  )
              );
            }
          return _widgetDisplayed;
        });
  }
}