import 'package:flutter/material.dart';

class HelpingPopup extends StatefulWidget {
  HelpingPopup(
      {Key? key,
      required this.currentStep,
      required this.totalStep,
      required this.msgToDisplay,
      this.onOk})
      : super(key: key);

  int currentStep, totalStep;
  String msgToDisplay;
  VoidCallback? onOk;

  @override
  _HelpingPopupState createState() => _HelpingPopupState();
}

class _HelpingPopupState extends State<HelpingPopup> {
  @override
  Widget build(BuildContext context) {
    final stepList = List.filled(widget.totalStep, null, growable: false);
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 30),
                    const SizedBox(width: 10),
                    Flexible(
                        child: Text(
                      widget.msgToDisplay,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: stepList.asMap().keys.toList().map((index) {
                      return Row(children: [
                        Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              color: index < widget.currentStep
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            )),
                        const SizedBox(width: 3)
                      ]);
                    }).toList()),
                    MaterialButton(
                        minWidth: 40,
                        height: 20,
                        color: Theme.of(context).primaryColor,
                        onPressed: () => {widget.onOk!()},
                        child: widget.currentStep == widget.totalStep
                            ? const Icon(Icons.check, size: 20)
                            : const Icon(Icons.navigate_next_outlined,
                                size: 20))
                  ],
                ),
              ],
            )));
  }
}
