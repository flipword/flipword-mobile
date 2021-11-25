import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, this.onUnFocus, this.focusNode}) : super(key: key);
  final ValueChanged<String>? onUnFocus;
  final FocusNode? focusNode;

  @override
  _State createState() => _State();
}

class _State extends State<SearchBar> with WidgetsBindingObserver {
  late InterfaceStore _interfaceStore;
  Timer? _debounce;
  TextEditingController? _textEditingController;
  String _previousInput = '';

  late Size screenSize;
  @override
  void initState() {
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    WidgetsBinding.instance!.addObserver(this);
    _textEditingController = TextEditingController()
      ..text = _interfaceStore.searchBarValue.value
      ..addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance!.window.viewInsets.bottom;
    if (value == 0) {
      widget.focusNode!.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
          child: Stack(
            children: [
              Container(
                  height: 30,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: _textEditingController,
                    focusNode: widget.focusNode,
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 12),
                        border: InputBorder.none,
                        hintText: 'Search word...',
                        prefixIcon: Icon(Icons.search)),
                  )),
              if (_interfaceStore.searchBarValue.value == '')
                const SizedBox()
              else
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          padding: const EdgeInsets.all(0),
                          onPressed: _clearSearch,
                        ),
                      )),
                ),
            ],
          )),
    ]);
  }

  void _onSearchChanged() {
    _interfaceStore.setSearchBarValue(_textEditingController!.value.text);
    if (_previousInput != _textEditingController!.value.text) {
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 300), () {
        widget.onUnFocus!(_textEditingController!.value.text);
      });
    }
    _previousInput = _textEditingController!.value.text;
  }

  void _clearSearch() {
    setState(() {
      _textEditingController!.text = '';
    });
    _interfaceStore.setSearchBarValue(_textEditingController!.value.text);
    widget.onUnFocus!(_textEditingController!.value.text);
  }
}
