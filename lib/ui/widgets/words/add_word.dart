import 'package:flutter/material.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

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
  final GlobalKey<SquareButtonState> _translateButtonKeyShowcase =
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
    super.initState();
    focusNode = FocusNode();
    _baseWordController = TextEditingController();
    _translateWordController = TextEditingController();
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    _interfaceStore = Provider.of<InterfaceStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    screenSize = MediaQuery.of(context).size.width;
    return GestureDetector(
        onVerticalDragUpdate: _onDragStop,
        onVerticalDragEnd: _onDragEnd,
        child: ShowCaseWidget(
            onFinish: _onBoardingFinish,
            builder: Builder(
                builder: (context) => SizedBox(
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
                                    Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            width: 500,
                                            height: 90,
                                            padding: const EdgeInsets.all(10),
                                            decoration: _getBoxDecoration(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/google-translate.svg',
                                                    height: 35,
                                                    width: 35),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Google',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 23),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Translate',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 23),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 250,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            height: 40,
                                            margin:
                                                const EdgeInsets.only(top: 88),
                                            decoration: _getBoxDecoration(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _settingStore.baseLanguage
                                                                .value !=
                                                            null
                                                        ? _settingStore
                                                            .baseLanguage
                                                            .value!
                                                            .label!
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
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          Showcase.withWidget(
                                                        key: _swapKey,
                                                        disableAnimation: true,
                                                        container: HelpingPopup(
                                                          currentStep: 1,
                                                          totalStep: 2,
                                                          msgToDisplay:
                                                              t.click_to_swap,
                                                          onOk:
                                                              ShowCaseWidget.of(
                                                                      context)!
                                                                  .next,
                                                        ),
                                                        width: 0,
                                                        height: 0,
                                                        child: FlatButton(
                                                            minWidth: 60,
                                                            height: 30,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            onPressed: () =>
                                                                _settingStore
                                                                    .reverseLanguage(),
                                                            child: Icon(
                                                                Icons
                                                                    .swap_horiz,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .color,
                                                                size: 20)),
                                                      )),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _settingStore
                                                                .translateLanguage
                                                                .value !=
                                                            null
                                                        ? _settingStore
                                                            .translateLanguage
                                                            .value!
                                                            .label!
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
                                            label: _settingStore
                                                        .baseLanguage.value !=
                                                    null
                                                ? _settingStore
                                                    .baseLanguage.value!.label
                                                : '',
                                            focusNode: focusNode,
                                            hintText: t.enter_word,
                                            onWordChanged: (_) => {},
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Showcase.withWidget(
                                          key: _translateButtonKeyShowcase,
                                          disableAnimation: true,
                                          overlayPadding:
                                              const EdgeInsets.all(10),
                                          container: HelpingPopup(
                                            currentStep: 2,
                                            totalStep: 2,
                                            msgToDisplay: t.translate_help,
                                            onOk: ShowCaseWidget.of(context)!
                                                .next,
                                          ),
                                          width: 0,
                                          height: 0,
                                          child: SquareButton(
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
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: InputWord(
                                              controller:
                                                  _translateWordController,
                                              label: _settingStore
                                                          .translateLanguage
                                                          .value !=
                                                      null
                                                  ? _settingStore
                                                      .translateLanguage
                                                      .value!
                                                      .label
                                                  : '',
                                              onWordChanged: (_) => {},
                                            )),
                                        const SizedBox(height: 5),
                                        IconTextButton(
                                          icon: Icons.save,
                                          color: Theme.of(context).primaryColor,
                                          text: t.save,
                                          onPressed: _saveCard,
                                        ),
                                        const SizedBox(height: 5)
                                      ]),
                                    )
                                  ]),
                                  Observer(builder: (context) {
                                    if (_interfaceStore
                                            .animationIsTerminated.value &&
                                        _interfaceStore
                                            .overlayIsDisplayed.value &&
                                        !_profilStore.currentProfile.value!
                                            .hasDidAddingOnBoarding) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback(
                                        (_) => ShowCaseWidget.of(context)!
                                            .startShowCase([
                                          _swapKey,
                                          _translateButtonKeyShowcase
                                        ]),
                                      );
                                      return const SizedBox();
                                    }
                                    return const SizedBox();
                                  })
                                ]))))))));
  }

  void _translateWord() {
    if (_baseWordController!.text.isEmpty) {
      _toastService.toastError(t.please_enter_word);
    } else {
      _translateButtonKey.currentState!.changeLoadingState();
      _settingStore
          .translate(
              _settingStore.baseLanguage.value!.isoCode,
              _settingStore.translateLanguage.value!.isoCode,
              _baseWordController!.text)
          .then((value) {
            _translateWordController!.text = value!;
          })
          .catchError(
              (onError) => _toastService.toastError(t.word_translate_error))
          .whenComplete(
              () => _translateButtonKey.currentState!.changeLoadingState());
    }
  }

  Future<void> _saveCard() async {
    try {
      if (_baseWordController!.text.isEmpty ||
          _translateWordController!.text.isEmpty) {
        _toastService.toastError(t.please_enter_word);
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
        _toastService.toastValidate(t.word_saved);
        await _cardListStore.fetchCard();
      }
    } catch (e) {
      _toastService.toastError(t.word_save_error);
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

  void _onBoardingFinish() {
    _profilStore.changeAddingOnBoardingStatus();
  }
}
