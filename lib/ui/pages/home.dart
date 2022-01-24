import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/widgets/language/choose_language.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/no_word.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  late CardListStore _cardListStore;
  late InterfaceStore _interfaceStore;
  late ProfilStore _profilStore;
  late bool _revealState;
  late bool _endOfSerie;
  late bool _foreignIsOnFront;

  @override
  void initState() {
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _revealState = false;
    _endOfSerie = false;
    _foreignIsOnFront = true;
    print('Init home');  // CALL 2x ????
    // if(!_profilStore.currentProfile.value!.hasChooseLanguage){
    //   WidgetsBinding.instance!
    //       .addPostFrameCallback((_) {
    //         print('Callback');
    //         _showChooseLanguageModal();
    //       });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    late Widget _widgetDisplayed;
    return Observer(builder: (context) {
      switch (_cardListStore.list.status) {
        case FutureStatus.pending:
          _widgetDisplayed = const Center(
            child: CircularProgressIndicator(),
          );
          break;
        case FutureStatus.rejected:
          _widgetDisplayed = Scaffold(
              body: Center(
                child: Column(children: const [
                  Icon(Icons.warning_amber_outlined),
                  Text('An error occured : the connection was rejected')
                ]),
              ));
          break;
        case FutureStatus.fulfilled:
          if (_cardListStore.length != 0) {
            _widgetDisplayed = Scaffold(
                body: Center(
                    child: Column(children: [
                  SizedBox(height: height / 10),
                  Center(
                      child: Text(
                    _endOfSerie ? 'Click to restart' : _revealState ? 'Is it ok ?' : 'Try to guess :',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  )),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height < 600 ? 5 : 20),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: FlipCard(
                      key: cardKey,
                      flipOnTouch: false,
                      front: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: (MediaQuery.of(context).size.width / 100) * 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: const Offset(2, 3), //(x,y)
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _getTextOnFront()!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25),
                            ),
                          )),
                      back: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: (MediaQuery.of(context).size.width / 100) * 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: const Offset(2, 3), //(x,y)
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                              child: Text(
                                _getTextOnBack()!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25),
                              ))),
                    )
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height < 600 ? 20 : 45),
                  if (_endOfSerie)
                    SquareButton(
                      onPressed: _interfaceStore.overlayIsDisplayed.value
                          ? null
                          : _restartSerie,
                      icon: const Icon(Icons.restore, size: 30),
                      backgroundColor: Theme.of(context).cardColor,
                      borderColor: Theme.of(context).primaryColor,
                      width: _getButtonSize(),
                      height: _getButtonSize(),
                    )
                  else if (_revealState)
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SquareButton(
                            onPressed: _interfaceStore.overlayIsDisplayed.value
                                ? null
                                : _errorFind,
                            icon: const Icon(Icons.clear, size: 30),
                            backgroundColor: Theme.of(context).cardColor,
                            borderColor: Theme.of(context).errorColor,
                            width: _getButtonSize(),
                            height: _getButtonSize(),
                          ),
                          SquareButton(
                            onPressed: _interfaceStore.overlayIsDisplayed.value
                                ? null
                                : () => {reviewCard()},
                            icon: const Icon(Icons.replay, size: 30),
                            backgroundColor: Theme.of(context).cardColor,
                            borderColor: Theme.of(context).primaryColor,
                            width: _getButtonSize(),
                            height: _getButtonSize(),
                          ),
                          SquareButton(
                            onPressed: _interfaceStore.overlayIsDisplayed.value
                                ? null
                                : _successFind,
                            icon: const Icon(Icons.check, size: 30),
                            backgroundColor: Theme.of(context).cardColor,
                            borderColor: Theme.of(context).indicatorColor,
                            width: _getButtonSize(),
                            height: _getButtonSize(),
                          )
                        ],
                      ),
                    )
                  else
                    SquareButton(
                      onPressed: _interfaceStore.overlayIsDisplayed.value
                          ? null
                          : _revealWord,
                      icon: const Icon(Icons.remove_red_eye, size: 30),
                      backgroundColor: Theme.of(context).cardColor,
                      borderColor: Theme.of(context).primaryColor,
                      width: _getButtonSize(),
                      height: _getButtonSize(),
                    )
                ])));
          } else {
            _widgetDisplayed = const NoWord();
          }
      }
      return _widgetDisplayed;
    });
  }

  String? _getTextOnFront() {
    return _foreignIsOnFront ? _cardListStore
        .list
        .result[_cardListStore.curentIndex.value]
        .foreignWord : _cardListStore
        .list
        .result[_cardListStore.curentIndex.value]
        .nativeWord;
  }

  String? _getTextOnBack() {
    return _foreignIsOnFront ? _cardListStore
        .list
        .result[_cardListStore.curentIndex.value]
        .nativeWord : _cardListStore
        .list
        .result[_cardListStore.curentIndex.value]
        .foreignWord ;
  }

  void reviewCard() {
    cardKey.currentState!.toggleCard();
    _foreignIsOnFront = !_foreignIsOnFront;
  }
  void _revealWord() {
    setState(() {
      _revealState = true;
    });
    cardKey.currentState!.toggleCard();
  }

  void _successFind() {
    if (!_cardListStore.isFinished) {
      setState(() {
        _revealState = false;
      });
      _foreignIsOnFront = !_foreignIsOnFront;
    } else {
      setState(() {
        _endOfSerie = true;
      });
    }
    _cardListStore.wordFinded(
        _cardListStore.list.value![_cardListStore.curentIndex.value!]);
  }

  void _errorFind() {
    if (!_cardListStore.isFinished) {
      setState(() {
        _revealState = false;
      });
      _foreignIsOnFront = !_foreignIsOnFront;
    } else {
      setState(() {
        _endOfSerie = true;
      });
    }
    _cardListStore.wordMissed(
        _cardListStore.list.value![_cardListStore.curentIndex.value!]);
  }

  void _restartSerie() {
    _cardListStore.resetIndex();
    setState(() {
      _endOfSerie = false;
      _revealState = false;
    });
    _foreignIsOnFront = true;
  }

  double _getButtonSize() {
    return MediaQuery.of(context).size.height < 600 ? 45 : 55;
  }

  void _showChooseLanguageModal() {
    BuildContext dialogContext;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)), //this right here
              child: ChooseLanguage(onClose: () {
                Navigator.of(dialogContext).pop();
              }),
          );
        });
  }
}
