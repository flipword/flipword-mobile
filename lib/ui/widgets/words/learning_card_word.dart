
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* This is the widget the corespond to the card that print the word */

class LearningCardWord extends StatelessWidget {
  String wordToFind;
  String wordTranslation;

  LearningCardWord({this.wordToFind, this.wordTranslation});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: [
          Text(this.wordTranslation),
          Text(this.wordToFind)
        ],
      ),
    );
  }
}