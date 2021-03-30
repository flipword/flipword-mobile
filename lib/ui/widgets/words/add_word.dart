import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_translate_repository.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/input_word.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class AddWord extends StatefulWidget {
  const AddWord({Key key, this.onDragUp, this.onDragEnd}) : super(key: key);

  final ValueChanged<DragUpdateDetails> onDragUp;
  final ValueChanged<DragEndDetails> onDragEnd;
  @override
  _State createState() => _State();
}

class _State extends State<AddWord> {
  final CardService _cardService = CardService.instance;
  final ToastService _toastService = ToastService.instance;

  final GlobalKey<SquareButtonState> _mybuttonState =
  GlobalKey<SquareButtonState>();
  final _formKey = GlobalKey<FormState>();

  final String translateIcon = 'assets/microsoft-translate.png';
  CardListStore _cardListStore;
  SettingStore _settingStore;

  TextEditingController _baseWordController;
  TextEditingController _translateWordController;
  FocusNode focusNode;
  double screenSize;

  @override
  void initState() {
    focusNode = FocusNode();
    _baseWordController = TextEditingController();
    _translateWordController = TextEditingController();
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return GestureDetector(
        onVerticalDragUpdate: _onDragStop,
        onVerticalDragEnd: _onDragEnd,
        child: SizedBox(
            width: screenSize,
            child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: Observer(builder: (_) {
                  if(_settingStore.nativeLanguage.status == FutureStatus.fulfilled && _settingStore.foreignLanguage.status == FutureStatus.fulfilled){
                    return Column(children: [
                      Stack(alignment: Alignment.topCenter, children: [
                        Container(
                          width: 500,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: _getBoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(translateIcon,
                                  height: 35, width: 35),
                              const SizedBox(width: 5),
                              const Text(
                                  'Microsoft',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 23),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                  'Translate',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 23),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          margin: const EdgeInsets.only(top: 88),
                          decoration: _getBoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(_settingStore.baseLanguage.label),
                                  )),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: FlatButton.icon(
                                      label: const Text(''),
                                      icon: const Icon(Icons.swap_horiz),
                                      textColor: Colors.black,
                                      onPressed: () => {_settingStore.reverseLanguage()}),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                    Text(_settingStore.translateLanguage.label),
                                  ))
                            ],
                          ),
                        )
                      ]),
                      Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: InputWord(
                              controller: _baseWordController,
                              label: _settingStore.baseLanguage.label,
                              focusNode: focusNode,
                              hintText: 'Enter your world',
                            ),
                          ),
                          const SizedBox(height: 15),
                          SquareButton(
                            key: _mybuttonState,
                            onPressed: () {
                              _translateWord();
                            },
                            icon: const Icon(Icons.translate_outlined, size: 30),
                            backgroundColor: Theme
                                .of(context)
                                .primaryColor,
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(height: 5),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: InputWord(
                                controller: _translateWordController,
                                label: _settingStore.translateLanguage.label,
                              )),
                          const SizedBox(height: 5),
                          IconTextButton(
                            width: 90,
                            icon: Icons.save,
                            color: Theme
                                .of(context)
                                .primaryColor,
                            text: 'Save',
                            onPressed: () {
                              _saveCard();
                            },
                          ),
                          const SizedBox(height: 5)
                        ]),
                      )
                    ]);
                  } else {
                    return const SizedBox();
                  }
                })
            )
        )
    );
  }

  void _translateWord() {
    if (_baseWordController.text.isEmpty) {
      _toastService.toastError('No word to translate');
    } else {
      _mybuttonState.currentState.changeLoadingState();
      TranslateHelper.instance
          .translate(_settingStore.baseLanguage.isoCode, _settingStore.translateLanguage.isoCode, _baseWordController.text)
          .then((value) {
        _translateWordController.text = value;
      })
          .catchError(
              (onError) => _toastService.toastError('Error on translate word'))
          .whenComplete(() => _mybuttonState.currentState.changeLoadingState());
    }
  }

  Future<void> _saveCard() async {
    try {
      if (_baseWordController.text.isEmpty ||
          _translateWordController.text.isEmpty) {
        _toastService.toastError('Please enter a word');
      } else {
        final baseWord = _formatWord(_baseWordController.text);
        final translateWord = _formatWord(_translateWordController.text);
        await _cardService.insertCard(baseWord, translateWord);
        _baseWordController.text = '';
        _translateWordController.text = '';
        focusNode.requestFocus();
        _toastService.toastValidate('Word save');
        await _cardListStore.fetchCard();
      }
    } catch (e) {
      _toastService.toastError('Error on insert card');
    }
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
    color: Theme.of(context).primaryColor,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).shadowColor,
        offset: const Offset(0, 3), //(x,y)
        blurRadius: 2,
      ),
    ],
  );

  String _formatWord(String word) {
    return '${word[0].toUpperCase()}${word.substring(1)}';
  }

  void _onDragStop(DragUpdateDetails dragUpdateDetails) {
    widget.onDragUp(dragUpdateDetails);
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    widget.onDragEnd(dragEndDetails);
  }
}