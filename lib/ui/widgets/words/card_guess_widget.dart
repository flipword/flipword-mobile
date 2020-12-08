
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class CardGuessWidget extends StatefulWidget {
  @override
  _CardGuessWidgetState createState() => _CardGuessWidgetState();
}

class _CardGuessWidgetState extends State<CardGuessWidget> {
  static  String wordFind = "le mot a deviner";
  static const String wordFound = "le mot trouvé";

  @override
  void initState() {
    print("LOG: [_CardGuessWidgetState] inistate : start");
    /*_learningCardList = Provider.of<LearningCardStore>(context, listen: false);
    if(_learningCardList.list.value.isEmpty) {
      //_learningCardList.fetchCard();
      print("LOG: [_CardGuessWidgetState] inistate : la liste est vide");
    }
    print("LOG: [_CardGuessWidgetState] inistate : fin");*/
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
