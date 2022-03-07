import 'package:flutter/material.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/interface/interface_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/on_boarding/helping_popup.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/input_word.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddWord extends StatefulWidget {
  const AddWord({Key? key, this.onDragUp, this.onDragEnd}) : super(key: key);

  final ValueChanged<DragUpdateDetails>? onDragUp;
  final ValueChanged<DragEndDetails>? onDragEnd;

  @override
  _State createState() => _State();
}

class _State extends State<AddWord> {
  final CardService _cardService = CardService.instance;
  final ToastService _toastService = ToastService.instance;

  final GlobalKey<SquareButtonState> _translateButtonKey =
      GlobalKey<SquareButtonState>();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey _swapKey = GlobalKey();

  int onBoardingStep = 1;
  late CardListStore _cardListStore;
  late SettingStore _settingStore;
  late ProfilStore _profilStore;
  late InterfaceStore _interfaceStore;

  TextEditingController? _baseWordController;
  TextEditingController? _translateWordController;
  FocusNode? focusNode;
  double? screenSize;

  @override
  void initState() {
    focusNode = FocusNode();
    _baseWordController = TextEditingController();
    _translateWordController = TextEditingController();
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
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
            child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Material(
                        color: Theme.of(context).backgroundColor,
                        elevation: 4,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        child: Stack(children: [
                          Column(children: [
                            Stack(alignment: Alignment.topCenter, children: [
                              Container(
                                width: 500,
                                height: 90,
                                padding: const EdgeInsets.all(10),
                                decoration: _getBoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/microsoft-translate.png',
                                        height: 35,
                                        width: 35),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Microsoft',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 23),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Translate',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 23),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 250,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                margin: const EdgeInsets.only(top: 88),
                                decoration: _getBoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _settingStore.baseLanguage != null
                                            ? _settingStore.baseLanguage!.label!
                                            : '',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color),
                                      ),
                                    )),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: FlatButton.icon(
                                            key: _swapKey,
                                            label: const Text(''),
                                            icon: const Icon(Icons.swap_horiz),
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color,
                                            onPressed: () => {
                                                  _settingStore
                                                      .reverseLanguage()
                                                }),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _settingStore.translateLanguage != null
                                            ? _settingStore
                                                .translateLanguage!.label!
                                            : '',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
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
                                    label: _settingStore.baseLanguage != null
                                        ? _settingStore.baseLanguage!.label
                                        : '',
                                    focusNode: focusNode,
                                    hintText: 'Enter your word',
                                    onWordChanged: (_) => {},
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SquareButton(
                                  key: _translateButtonKey,
                                  onPressed: _translateWord,
                                  icon: Icon(
                                    Icons.translate_outlined,
                                    size: 30,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  width: 45,
                                  height: 45,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: InputWord(
                                      controller: _translateWordController,
                                      label: _settingStore.translateLanguage !=
                                              null
                                          ? _settingStore
                                              .translateLanguage!.label
                                          : '',
                                      onWordChanged: (_) => {},
                                    )),
                                const SizedBox(height: 5),
                                IconTextButton(
                                  width: 90,
                                  icon: Icons.save,
                                  color: Theme.of(context).primaryColor,
                                  text: 'Save',
                                  onPressed: _saveCard,
                                ),
                                const SizedBox(height: 5)
                              ]),
                            )
                          ]),
                          Observer(builder: (context) {
                            if (!_profilStore.currentProfile.value!
                                    .hasDidAddingOnBoarding &&
                                _interfaceStore.animationIsTerminated.value) {
                              return HelpingPopup(
                                parentKey: _translateButtonKey,
                                currentStep: onBoardingStep,
                                totalStep: 2,
                                msgToDisplay: onBoardingStep == 1
                                    ? 'Click to swap the translation direction'
                                    : 'Click to translate the word written in first box',
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                        ]))))));
  }

  void _translateWord() {
    if (_baseWordController!.text.isEmpty) {
      _toastService.toastError('No word to translate');
    } else {
      _translateButtonKey.currentState!.changeLoadingState();
      _settingStore
          .translate(
              _settingStore.baseLanguage!.isoCode,
              _settingStore.translateLanguage!.isoCode,
              _baseWordController!.text)
          .then((value) {
            _translateWordController!.text = value!;
          })
          .catchError(
              (onError) => _toastService.toastError('Error on translate word'))
          .whenComplete(
              () => _translateButtonKey.currentState!.changeLoadingState());
    }
  }

  Future<void> _saveCard() async {
    try {
      if (_baseWordController!.text.isEmpty ||
          _translateWordController!.text.isEmpty) {
        _toastService.toastError('Please enter a word');
      } else {
        final baseWord = _formatWord(_baseWordController!.text);
        final translateWord = _formatWord(_translateWordController!.text);
        final nativeWord =
            _settingStore.isReverseLanguage ? translateWord : baseWord;
        final foreignWord =
            _settingStore.isReverseLanguage ? baseWord : translateWord;
        await _cardService.insertCard(nativeWord, foreignWord);
        _baseWordController!.text = '';
        _translateWordController!.text = '';
        focusNode!.requestFocus();
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
    widget.onDragUp!(dragUpdateDetails);
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    widget.onDragEnd!(dragEndDetails);
  }
}
