import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:flutter_flip_card/ui/widgets/words/detail_word.dart';
import 'package:flutter_flip_card/ui/widgets/words/search_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ListWordPage extends StatefulWidget {
  static const String routeName = '/list';

  @override
  ListWordPageState createState() => ListWordPageState();
}

class ListWordPageState extends State<ListWordPage> {
  CardListStore _cardList;
  InterfaceStore _interfaceStore;
  final CardService _cardService = CardService.instance;
  final ToastService _toastService = ToastService.instance;

  @override
  void initState() {
    _cardList = Provider.of<CardListStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Widget _widgetDisplayed;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Observer(builder: (_) {
        switch (_cardList.list.status) {
          case FutureStatus.pending:
            _widgetDisplayed = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case FutureStatus.fulfilled:
            _widgetDisplayed = Scaffold(
                body: _cardList.length == 0
                    ? GridView.count(
                        crossAxisCount: 1,
                        physics: _interfaceStore.overlayIsDisplayed.value
                            ? const BouncingScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        children: [
                            const Center(
                              child: Text('No word'),
                            )
                          ])
                    : GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: _calculElementDisplay(screenSize),
                        crossAxisCount: 2,
                        physics: _interfaceStore.overlayIsDisplayed.value
                            ? const BouncingScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        semanticChildCount: 10,
                        children: List.generate(
                            _cardList.length,
                            (index) => IgnorePointer(
                                  ignoring:
                                      _interfaceStore.overlayIsDisplayed.value,
                                  child: GestureDetector(
                                    onTap: () => {
                                      _showModal(_cardList.list.result[index])
                                    },
                                    child: CardWord(
                                        nativeWord: _cardList
                                            .list.result[index].nativeWord.word,
                                        foreignWord: _cardList.list
                                            .result[index].foreignWord.word),
                                  ),
                                ))));
            break;
          case FutureStatus.rejected:
            _widgetDisplayed = const Center(
                child: Text(
              'Fail',
              textAlign: TextAlign.center,
            ));
            break;
        }
        return Stack(children: [
          Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: _widgetDisplayed),
          SearchBar(
            onUnFocus: (value) => {_filterCard(value)},
          ),
        ]);
      }),
    );
  }

  Future<void> _refresh() => _cardList.fetchCard();

  double _calculElementDisplay(screenSize) {
    if (screenSize.height > 1000) {
      return 3;
    } else if (screenSize.height > 800) {
      return 2.5;
    } else if (screenSize.height > 600) {
      return 2;
    } else {
      return 1.5;
    }
  }

  void _showModal(CardEntity card) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)), //this right here
            child: DetailWord(card: card, onDelete: _deleteWord)));
  }

  void _deleteWord(String id) {
    _cardService
        .deleteCard(id)
        .then((value) =>
            {_toastService.toastValidate('Card delete with success')})
        .catchError(
            (onError) => {_toastService.toastError('Error on deleting card')})
        .whenComplete(() => Navigator.of(context, rootNavigator: true).pop());
    _cardList
      ..resetIndex()
      ..fetchCard();
  }

  void _filterCard(value) {
    _cardList.filterCard(value);
  }
}
