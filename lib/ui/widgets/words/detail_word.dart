import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class DetailWord extends StatefulWidget {
  const DetailWord({Key key, @required this.card, @required this.onDelete}): super(key: key);

  final CardEntity card;
  final ValueChanged<String> onDelete;

  @override
  _DetailWordState createState() => _DetailWordState();
}

class _DetailWordState extends State<DetailWord> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 175 ,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
            height: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CardWord(nativeWord: widget.card.nativeWord.word, foreignWord: widget.card.foreignWord.word),
            ),
            const SizedBox(height: 5),
            FlatButton.icon(
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
                textColor: Colors.black,
                color: Theme.of(context).errorColor,
                onPressed: () => {widget.onDelete(widget.card.id)}
            ),
            const SizedBox(height: 5),
          ],
        )
      );
  }
}