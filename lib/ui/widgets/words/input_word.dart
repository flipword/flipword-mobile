import 'package:flutter/material.dart';

class InputWord extends StatefulWidget {
  const InputWord(
      {Key key,
      @required this.label,
      this.hintText = '',
      this.readOnly = false,
      this.onWordChanged,
      this.controller,
      this.focusNode})
      : super(key: key);

  final String label;
  final String hintText;
  final bool readOnly;
  final ValueChanged<String> onWordChanged;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _InputWordState createState() => _InputWordState();
}

class _InputWordState extends State<InputWord> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(widget.label, textAlign: TextAlign.center),
              ),
            ),
          )
        ],
      ),
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(0, 3), //(x,y)
                blurRadius: 2,
              ),
            ]),
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyText2.color),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 30, bottom: 30),
            border: InputBorder.none,
            hintText: widget.hintText,
          ),
          onChanged: (value) => {_onWordChanged(value)},
        ),
      )
    ]);
  }

  void _onWordChanged(String value) {
    widget.onWordChanged(value);
  }
}
