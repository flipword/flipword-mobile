import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
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

  static  String wordFind = 'le mot a deviner';
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
    return Container(
      child : Column(
        children :[
          Text(wordFind, style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400
          )),
          Text(_cardListStore.list.result[_cardListStore.curentIndex.value].foreignWord.word, textAlign: TextAlign.left),
          Text((() {
          if (_cardListStore.found.value) {
           return(_cardListStore.list.result[_cardListStore.curentIndex.value].nativeWord.word);
          }
          else {
            return('????');
          }})()),
          IconButton(
            icon: Icon(Icons.question_answer),
              onPressed: () { }
              )
        ]
    ));
  }
}
