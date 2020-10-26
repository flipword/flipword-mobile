import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/translate_helper.dart';
import 'package:flutter_flip_card/service/language_service.dart';
import 'package:flutter_flip_card/ui/components/button/icon_text_button.dart';
import 'package:flutter_flip_card/ui/components/button/square_button.dart';
import 'package:flutter_flip_card/ui/components/input/word_input.dart';
import 'package:flutter_svg/svg.dart';

class AddWord extends StatefulWidget {
  @override
  _State createState() => _State();

}


class _State extends State<AddWord> {
  LanguageService _languageService = LanguageService.instance;

  final _formKey = GlobalKey<FormState>();

  final String googleTranslateAsset = 'assets/google-translate.svg';
  var baseWord = '';
  var translateWord = '';
  Language baseLanguage;
  Language translateLanguage;
  TextEditingController _controller;
  double screenSize;


  @override
  void initState() {
    baseLanguage = _languageService.nativeLanguage;
    translateLanguage = _languageService.foreignLanguage;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Positioned(
      width: screenSize,
      child: Material(
          color: Theme
              .of(context)
              .backgroundColor,
          elevation: 4.0,
          borderRadius: BorderRadius.circular(30.0),
          child: Column(
              children: [
                Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          width: 500,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  googleTranslateAsset, height: 35, width: 35),
                              SizedBox(width: 5),
                              Text(
                                'Google',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30
                                ),
                              ),
                              Text(
                                'Translate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30
                                ),
                              )
                            ],
                          ),
                          decoration: _getBoxDecoration()
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
                                  child: Text(translateLanguage.label),
                                  alignment: Alignment.center,
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
                        SizedBox(height: 10),
                        WordInput(
                            label: baseLanguage.label,
                            hintText: 'Enter your world',
                            onWordChanged: (value) => {_updateBaseWord(value)} ,
                        ),
                        SizedBox(height: 15),
                        SquareButton(
                          onPressed: () {_translateWord();},
                          icon: Icon(Icons.g_translate, size: 30),
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                          width: 45.0,
                          height: 45.0,
                        ),
                        const SizedBox(height: 5),
                        WordInput(
                            controller: _controller,
                            label: translateLanguage.label,
                            onWordChanged: (value) => {
                              _updateTranslateWord(value)
                            },
                        ),
                        const SizedBox(height: 5),
                        IconTextButton(
                          width: 90,
                          icon: Icons.save,
                          text: 'Save',
                          onPressed: () {_translateWord();},
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
      var temp = this.baseLanguage;
      this.baseLanguage = this.translateLanguage;
      this.translateLanguage = temp;
    });
  }

  void _translateWord() async {
    // TODO: msg informatif success/error
    var word = await  TranslateHelper.instance.translate(baseLanguage.id, translateLanguage.id, baseWord);
    _controller.text = word.toString();
  }

  void _updateBaseWord(String value) {
    setState(() {
      baseWord = value;
    });
  }

  void _updateTranslateWord(String value) {
    setState(() {
      translateWord = value;
    });
  }

  BoxDecoration _getBoxDecoration() =>
      BoxDecoration(color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 3.0), //(x,y)
            blurRadius: 2,
          ),
        ],
      );
}
