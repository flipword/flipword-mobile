import 'dart:ffi';

import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  IconTextButton({Key key, this.icon, this.text, this.backgroundColor, this.width , @required this.onPressed} ): super(key: key);

  final IconData icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double width ;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: MaterialButton(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onPressed: () => {onPressed()},
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top:5.0, right: 10.0, bottom: 5.0, left: 10.0),
          child: Row( // Replace with a Row for horizontal icon + text
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(icon, size: 30),
              Text(this.text)
            ],
          ),
        )
    );
  }
}
