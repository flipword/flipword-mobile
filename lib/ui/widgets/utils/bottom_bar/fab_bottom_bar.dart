import 'package:flutter/material.dart';

class FABBottomAppBarItemRouting {
  FABBottomAppBarItemRouting({@required this.index, @required this.routeName});

  int index;
  String routeName;
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({@required this.iconData, @required this.routeName});

  IconData iconData;
  String routeName;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.height = 60.0,
    this.iconSize = 30.0,
    this.backgroundColor,
    this.iconColor,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    Key key
  }): super(key: key) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<String> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

 void _updateRoute(FABBottomAppBarItemRouting routing) {
    widget.onTabSelected(routing.routeName);
    setState(() {
      _selectedIndex = routing.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 500;
    final items = List<Widget>.generate(widget.items.length, (int index) {
      return _buildTabItem(
          item: widget.items[index],
          index: index,
          onPressed: _updateRoute,
          isLargeScreen: isLargeScreen
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem(isLargeScreen));

    return BottomAppBar(
      color: widget.backgroundColor,
      //shape: widget.notchedShape,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
       ),
    );
  }

  Widget _buildMiddleTabItem(bool isLargeScreen) {
    final middleTabItem = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize)
          ],
        );
    return isLargeScreen ?
    SizedBox(
      width: 100,
      height: widget.height,
      child: middleTabItem,
    ) :
    Expanded(
        child: SizedBox(
          height: widget.height,
          child: middleTabItem,
        )
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<FABBottomAppBarItemRouting> onPressed,
    bool isLargeScreen
  }) {
    final routing = FABBottomAppBarItemRouting(
        index: index,
        routeName: item.routeName);
    final color = _selectedIndex == index ?
    widget.selectedColor
        : widget.iconColor;
    final tabItemElement = Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(routing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize)
              ],
            ),
          ),
      );
    return isLargeScreen ?
        SizedBox(
          width: 100,
          height: widget.height,
          child: tabItemElement,
        ) :
        Expanded(
            child: SizedBox(
              height: widget.height,
              child: tabItemElement,
            )
        );
  }
}