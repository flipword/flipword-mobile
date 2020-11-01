import 'package:flutter/material.dart';

class CardWord extends StatelessWidget {
  CardWord({Key key, @required this.nativeWord, @required this.foreignWord}): super(key: key);

  String nativeWord;
  String foreignWord;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                nativeWord,
                textAlign: TextAlign.center,
              ),
            )
        ),
        Container(
            padding: const EdgeInsets.only(left:10, right: 10),
            height: 40,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3
                )
            ),
            child: Center(
              child: Text(
                foreignWord,
                textAlign: TextAlign.center,
              ),
            )
        )
      ],
    );
  }
}
