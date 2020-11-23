
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/learning_card/learning_card_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class CardGuessWidget extends StatefulWidget {
  @override
  _CardGuessWidgetState createState() => _CardGuessWidgetState();
}

class _CardGuessWidgetState extends State<CardGuessWidget> {
  LearningCardStore _learningCardList;
  static  String wordFind = "le mot a deviner";
  static const String wordFound = "le mot trouvé";

  void initState() {
    _learningCardList = Provider.of<LearningCardStore>(context, listen: false);
    if(_learningCardList.list.value.isEmpty) {
      //_learningCardList.fetchCard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child : Row(
        children :[
          Text(wordFind),
          IconButton(
            icon: Icon(Icons.question_answer),
              onPressed: () { })
          ,]
          /*children: List.generate(_learningCardList.length, (index) => CardWord(
              nativeWord: _learningCardList.list.result[index].nativeWord.word,
              foreignWord: _learningCardList.list.result[index].foreignWord.word
          ))*/

      )
    );
  }
}
