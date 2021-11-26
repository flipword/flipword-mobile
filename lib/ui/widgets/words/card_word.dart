import 'package:flutter/material.dart';

class CardWord extends StatelessWidget {
  CardWord(
      {
        required this.nativeWord,
        required this.foreignWord,
        required this.color,
        this.height = 40,
        Key? key
      })
      : super(key: key);

  String? nativeWord;
  String? foreignWord;
  Color color;
  double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: height - 1),
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: height,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(color: color, width: 3)),
            child: Center(
              child: Text(
                foreignWord!,
                textAlign: TextAlign.center,
              ),
            )),
        Container(
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                nativeWord!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
            ))
      ],
    );
  }
}
