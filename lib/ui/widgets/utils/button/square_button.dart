import 'package:flutter/material.dart';

class SquareButton extends StatefulWidget {
  const SquareButton(
      {Key? key,
      this.icon,
      this.borderColor,
      this.backgroundColor,
      this.width = 60.0,
      this.height = 60.0,
      this.loadingStatement = false,
      required this.onPressed})
      : super(key: key);

  final Icon? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool loadingStatement;
  @override
  SquareButtonState createState() => SquareButtonState();
}

class SquareButtonState extends State<SquareButton> {
  late bool loading;
  @override
  void initState() {
    loading = widget.loadingStatement;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: RawMaterialButton(
              fillColor: widget.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      width: 2,
                      color: widget.borderColor ?? widget.backgroundColor!)),
              splashColor: Theme.of(context).backgroundColor,
              elevation: 10,
              highlightElevation: 0,
              onPressed: widget.onPressed,
              child: loading
                  ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).cardColor,
                    )
                  : RotationTransition(
                      turns: const AlwaysStoppedAnimation(-45 / 360),
                      child: widget.icon,
                      ),
            )));
  }

  void changeLoadingState() {
    setState(() {
      loading = !loading;
    });
  }
}
