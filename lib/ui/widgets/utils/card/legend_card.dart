import 'package:flutter/material.dart';

class LegendCard extends StatelessWidget {
  const LegendCard({
    Key key,
    @required this.legend,
    this.margin,
    this.child,
    this.padding,
  }) : super(key: key);

  final String legend;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(legend, textAlign: TextAlign.center),
                  ),
                ),
              )
            ],
          ),
          Container(
              padding: padding,
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
              child: child)
        ]));
  }
}
