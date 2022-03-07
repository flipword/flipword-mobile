import 'package:flutter/material.dart';

class HelpingPopup extends StatefulWidget {
  HelpingPopup(
      {Key? key,
      required this.parentKey,
      required this.currentStep,
      required this.totalStep,
      required this.msgToDisplay,
      this.onOk})
      : super(key: key);

  GlobalKey parentKey;
  int currentStep, totalStep;
  String msgToDisplay;
  VoidCallback? onOk;

  @override
  _HelpingPopupState createState() => _HelpingPopupState();
}

class _HelpingPopupState extends State<HelpingPopup> {
  double _xPopupOffset = 0;
  double _yPopupOffset = 0;

  @override
  Widget build(BuildContext context) {
    _getPopupOffset();
    return Positioned(
      top: _yPopupOffset,
      left: _xPopupOffset,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(width: 200, height: 150)),
    );
  }

  void _getPopupOffset() {
    print('COmponent build');
    final box =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox?;
    final position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      setState(() {
        _xPopupOffset = position.dx + 30;
        _yPopupOffset = position.dy + 30;
      });
    }
  }
}
