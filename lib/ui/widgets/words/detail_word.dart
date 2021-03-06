import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class DetailWord extends StatefulWidget {
  const DetailWord(
      {Key? key, required this.card, required this.onDelete, this.onClose})
      : super(key: key);

  final CardEntity? card;
  final ValueChanged<String?> onDelete;
  final VoidCallback? onClose;

  @override
  _DetailWordState createState() => _DetailWordState();
}

class _DetailWordState extends State<DetailWord> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Container(
            height: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  height: 25,
                  alignment: Alignment.topRight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.clear),
                      padding: const EdgeInsets.only(top: 5),
                      onPressed: widget.onClose),
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CardWord(
                        nativeWord: widget.card!.nativeWord,
                        foreignWord: widget.card!.foreignWord,
                        color: Theme.of(context).primaryColor)),
                Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(children: [
                      Expanded(
                        child: CardWord(
                          nativeWord: t.word_error,
                          foreignWord: widget.card!.nbErrors.toString(),
                          color: Theme.of(context).errorColor,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                          child: CardWord(
                        nativeWord: t.word_views,
                        foreignWord:
                            (widget.card!.nbErrors! + widget.card!.nbSuccess!)
                                .toString(),
                        color: Theme.of(context).primaryColor,
                        height: 30,
                      )),
                      const SizedBox(width: 5),
                      Expanded(
                          child: CardWord(
                        nativeWord: t.word_success,
                        foreignWord: widget.card!.nbSuccess.toString(),
                        color: Theme.of(context).indicatorColor,
                        height: 30,
                      ))
                    ])),
                const SizedBox(height: 5),
                IconTextButton(
                    text: t.delete,
                    icon: Icons.delete,
                    width: 100,
                    color: Theme.of(context).errorColor,
                    onPressed: () => {widget.onDelete(widget.card!.id)}),
                const SizedBox(height: 5),
              ],
            )));
  }
}
