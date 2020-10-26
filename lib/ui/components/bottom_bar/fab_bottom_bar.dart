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
  }) {
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
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateRoute,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      color: widget.backgroundColor,
      //shape: widget.notchedShape,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize)
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<FABBottomAppBarItemRouting> onPressed,
  }) {
    FABBottomAppBarItemRouting routing = FABBottomAppBarItemRouting(
        index: index,
        routeName: item.routeName);
    final Color color = _selectedIndex == index ?
    widget.selectedColor
        : widget.iconColor;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
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
        ),
      ),
    );
  }
}