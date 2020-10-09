import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  SquareButton({Key key, this.icon, this.backgroundColor, @required this.onPressed}): super(key: key);

  final Icon icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(45 / 360),
          child: new RawMaterialButton(
            fillColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 5.0,
            child: new RotationTransition(
              turns: new AlwaysStoppedAnimation(45 / 360),
              child: icon
            ),
            onPressed: (){ onPressed(); },
          )
      )
    );
  }
}
