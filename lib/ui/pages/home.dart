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
  LearningCardStore _learningCardList;

  void initState() {
    _learningCardList = Provider.of<LearningCardStore>(context, listen: false);
    if(_learningCardList.list.value.isEmpty) {
      //_learningCardList.fetchCard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          /*children: List.generate(_learningCardList.length, (index) => CardWord(
                nativeWord: _learningCardList.list.result[index].nativeWord.word,
                foreignWord: _learningCardList.list.result[index].foreignWord.word
              )
            )*/
          children: [
            /* WIP : J'ai décidé de créer un widget spécifique our afficher la carte du mot a deviner*/
            CardGuessWidget(),
            //GuessButton()
          ],
        )
    );
  }
}