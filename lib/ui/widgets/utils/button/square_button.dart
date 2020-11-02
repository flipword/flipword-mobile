
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({Key key, this.icon, this.backgroundColor, this.width = 60.0 , this.height = 60.0, @required this.onPressed} ): super(key: key);

  final Icon icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double width ;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: RawMaterialButton(
            fillColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
            ),
            splashColor: Theme.of(context).accentColor,
            elevation: 10.0,
            highlightElevation: 0,
            onPressed: (){ onPressed(); },
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360),
              child: Opacity(
                opacity: 0.7,
                child: icon,
              )
            ),
          )
      )
    );
  }
}
