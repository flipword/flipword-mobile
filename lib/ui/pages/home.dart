import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/guess_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:flutter_flip_card/ui/widgets/words/learning_card_word.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;
import 'package:flutter_flip_card/store/learning_card/learning_card_store.dart';

import 'card_guess_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  /*LearningCardStore _learningCardList;

  @override
  void initState() {
    print("LOG: [_HomePageState] inistate : start");
    _learningCardList = Provider.of<LearningCardStore>(context, listen: false);
    if(_learningCardList.list.value.isEmpty) {
      print("LOG: [_HomePageState] inistate : la liste est vide, je vais 'fetch'");
      _learningCardList.fetchCard();
    }
    print("LOG: [_HomePageState] inistate : fin");
    super.initState();
  }*/
  //TODO je teste avec le _cardList alors qu'on avait vu d'utiliser un second store our cette artie,
  // mais le store ne marche pas encore...
  CardListStore _cardList;

  var listCard = null;
  @override
  void initState() {
    print("LOG: [_HomePageState] inistate : start");
    _cardList = Provider.of<CardListStore>(context, listen: false);
    if(_cardList.list.value.isEmpty) {
      print("LOG: [_HomePageState] inistate : la liste est vide, je vais 'fetch'");
      _cardList.fetchCard();
      print("LOG: [_HomePageState] inistate : " + _cardList.length.toString());
    }
    print("LOG: [_HomePageState] inistate : fin");
    super.initState();
  }

  void increaseCounter() {
    setState(() {
      print("LOG: [_HomePageState] increaseCounter : j'incremente  " + _index.toString());
      _index += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row (
            children: [
              Column(
          children: List.generate(_cardList.length, (index) => CardWord(
                nativeWord: _cardList.list.result[index].nativeWord.word,
                foreignWord: _cardList.list.result[index].foreignWord.word
              )
            )
        ),
              Text(_cardList.list.result[_index].nativeWord.word),
              Text(_cardList.list.result[_index].foreignWord.word),
              IconButton(
                icon: Icon(Icons.question_answer_outlined), onPressed: () { increaseCounter(); }),
              Text('$_index')
    ]
    )
    )
    ;
  }
}