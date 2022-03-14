import 'package:flutter/material.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';

class NoWord extends StatelessWidget {
  const NoWord({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.no_word,
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            t.click_to_add_word,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    ));
  }
}
