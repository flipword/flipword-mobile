import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {Key key,
      this.icon,
      this.text,
      this.backgroundColor,
      this.width,
      @required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: MaterialButton(
            splashColor: Theme.of(context).accentColor,
            elevation: 10,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () => {onPressed()},
            color: Theme.of(context).primaryColor,
            padding:
                const EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
            child: Opacity(
              opacity: 0.7,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(text), Icon(icon, size: 30)]),
            )));
  }
}
