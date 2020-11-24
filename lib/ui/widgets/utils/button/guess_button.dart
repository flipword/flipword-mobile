
import 'package:flutter/material.dart';

class GuessButton extends StatefulWidget {
  @override
  _StateGuessButton createState() => _StateGuessButton();
}

class _StateGuessButton extends State<GuessButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.question_answer_outlined),
        onPressed: (
            ) {
      }
    );
  }
}

