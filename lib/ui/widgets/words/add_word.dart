import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_translate_repository.dart';
import 'package:flutter_flip_card/data/entities/word.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/square_button.dart';
import 'package:flutter_flip_card/ui/widgets/words/input_word.dart';
import 'package:flutter_svg/svg.dart';


class AddWord extends StatefulWidget {

  const AddWord({Key key}) : super(key: key);

  @override
  _State createState() => _State();

}


class _State extends State<AddWord> {
  final LanguageService _languageService = LanguageService.instance;
  final CardService _cardService = CardService.instance;
  final ToastService _toastService = ToastService.instance;

  final GlobalKey<SquareButtonState> _mybuttonState = GlobalKey<SquareButtonState>();
  final _formKey = GlobalKey<FormState>();

  final String googleTranslateAsset = 'assets/google-translate.svg';
  Language baseLanguage;
  Language translateLanguage;
  TextEditingController _baseWordController;
  TextEditingController _translateWordController;
  double screenSize;


  @override
  void initState() {
    baseLanguage = _languageService.nativeLanguage;
    translateLanguage = _languageService.foreignLanguage;

    _baseWordController = TextEditingController();
    _translateWordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenSize,
      child: Material(
          color: Theme
              .of(context)
              .backgroundColor,
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          child: Column(
              children: [
                Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          width: 500,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: _getBoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  googleTranslateAsset, height: 35, width: 35),
                              const SizedBox(width: 5),
                              const Text(
                                'Google',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30
                                ),
                              ),
                              const Text(
                                'Translate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30
                                ),
                              )
                            ],
                          ),
                      ),
                      Container(
                        width: 250,
                        padding: const EdgeInsets.only(left:10, right: 10),
                        height: 40,
                        margin: const EdgeInsets.only(top: 88),
                        decoration: _getBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(

                              child: Container(
                                alignment: Alignment.center,
                                child: Text(baseLanguage.label),
                              )
                            ),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child : FlatButton.icon(
                                    label: const Text(''),
                                    icon: const Icon(Icons.swap_horiz),
                                    textColor: Colors.black,
                                    onPressed: () => {_reverseLanguage()}
                                  ),
                                ),
                            ),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(translateLanguage.label),
                                )
                            )
                          ],
                        ),
                      )
                    ]
                ),
                Form(
                  key: _formKey,
                  child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: InputWord(
                            controller: _baseWordController,
                            label: baseLanguage.label,
                            hintText: 'Enter your world',
                          ),
                        ),
                        const SizedBox(height: 15),
                        SquareButton(
                          key: _mybuttonState,
                          onPressed: () {_translateWord();},
                          icon: const Icon(Icons.g_translate, size: 30),
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                          width: 45,
                          height: 45,
                        ),
                        const SizedBox(height: 5),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InputWord(
                              controller: _translateWordController,
                              label: translateLanguage.label,
                            )
                        ),
                        const SizedBox(height: 5),
                        IconTextButton(
                          width: 90,
                          icon: Icons.save,
                          text: 'Save',
                          onPressed: () {_saveCard();},
                        ),
                        const SizedBox(height: 5)
                      ]),
                )
              ]
          )
      ),
    );
  }

  void _reverseLanguage() {
    setState(() {
      final temp = baseLanguage;
      baseLanguage = translateLanguage;
      translateLanguage = temp;
    });
  }

  void _translateWord()  {
    if(_baseWordController.text.isEmpty){
      _toastService.toastError('No word to translate');
    }else{
      _mybuttonState.currentState.changeLoadingState();
      TranslateHelper.instance.translate(
          baseLanguage.id,
          translateLanguage.id,
          _baseWordController.text
      )
          .then((value) {_translateWordController.text = value;})
          .catchError((onError) => _toastService.toastError('Error on translate word'))
          .whenComplete(() => _mybuttonState.currentState.changeLoadingState());
    }
  }

  Future<void> _saveCard() async {
    try {
      if(_baseWordController.text.isEmpty || _translateWordController.text.isEmpty) {
        _toastService.toastError('Please enter a word');
      }else{
        final baseWord = Word(word: _formatWord(_baseWordController.text), languageId: baseLanguage.id);
        final translateWord = Word(word: _translateWordController.text, languageId: translateLanguage.id);
        await _cardService.insertCard(baseWord, translateWord);
        _baseWordController.text = '';
        _translateWordController.text = '';
        _toastService.toastValidate('Word save');
      }
    } catch (e) {
      _toastService.toastError('Error on insert card');
    }
  }

  BoxDecoration _getBoxDecoration() =>
      BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3), //(x,y)
            blurRadius: 2,
          ),
        ],
      );

  String _formatWord(String word){
    return '${word[0].toUpperCase()}${word.substring(1)}';
  }
}
