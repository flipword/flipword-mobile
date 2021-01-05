import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key, this.onUnFocus}) : super(key: key);
  final ValueChanged<String> onUnFocus;

  @override
  _State createState() => _State();
}

class _State extends State<SearchBar> {
  TextEditingController _searchController;
  Timer _debounce;
  String _previousInput = '';

  Size screenSize;
  @override
  void initState() {
    _searchController = TextEditingController()..addListener(_onSearchChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
          width: screenSize.width,
          alignment: Alignment.bottomCenter,
          height: screenSize.height / 10,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(2, 3), //(x,y)
                blurRadius: 2,
              ),
            ],
          ),
          child: Container(
            height: 30,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: TextFormField(
              controller: _searchController,
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText2.color),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 15),
                  border: InputBorder.none,
                  hintText: 'Search word...',
                  prefixIcon: Icon(Icons.search)),
            ),
          )),
    ]);
  }

  void _onSearchChanged() {
    if (_previousInput != _searchController.value.text) {
      if (_debounce?.isActive ?? false) {
        _debounce.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 800), () {
        widget.onUnFocus(_searchController.value.text);
      });
    }
    _previousInput = _searchController.value.text;
  }
}
