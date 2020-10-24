import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordInput extends StatefulWidget {
  WordInput({Key key, @required this.label, this.hintText = '', this.readOnly = false, this.onWordChanged, this.controller}): super(key: key);

  final String label;
  final String hintText;
  final bool readOnly;
  final ValueChanged<String> onWordChanged;
  final TextEditingController controller;

  @override
  _WordInputState createState() => _WordInputState();
}

class _WordInputState extends State<WordInput> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                          widget.label,
                          textAlign: TextAlign.center
                      ),
                    ),
                    decoration: BoxDecoration (
                        color: Theme.of(context).cardColor,
                        borderRadius: new BorderRadius.only(topLeft: new Radius.circular(8.0), topRight: new Radius.circular(8.0)),
                    ),
                ),
              )
            ],
          ),
          Container(
              child: TextFormField(
                controller: widget.controller,
                readOnly: widget.readOnly,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 30, bottom: 30),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                ),
                onChanged: (value) => {_onWordChanged(value)},
              ),
              decoration: BoxDecoration (
                color: Theme.of(context).cardColor,
                borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 3.0), //(x,y)
                    blurRadius: 2,
                  ),
                ]
              )
          )
        ]
    );
  }

  void _onWordChanged(value) {
    widget.onWordChanged(value);
  }
}