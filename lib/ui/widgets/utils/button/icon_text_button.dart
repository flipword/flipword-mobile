import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {Key key,
      this.icon,
      this.text,
      this.color,
      this.width,
      @required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
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
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () => {onPressed()},
            color: color,
            padding:
                const EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
            child: Opacity(
              opacity: 0.7,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2.color)),
                    Icon(icon,
                        size: 30, color: Theme.of(context).iconTheme.color)
                  ]),
            )));
  }
}
