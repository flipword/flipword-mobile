import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_service.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/translate_helper.dart';
import 'package:flutter_flip_card/data/entities/dictionary.dart';
import 'package:flutter_flip_card/service/firebaseServices/firebase_auth_service.dart';
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
  FirestoreService _firebaseFirestore = FirestoreService.instance;
  FirebaseAuthService _authService = FirebaseAuthService.instance;


  final _formKey = GlobalKey<FormState>();

  final String googleTranslateAsset = 'assets/google-translate.svg';
  var baseWord = '';
  var translateWord = '';
  Language baseLanguage;
  Language translateLanguage;
  TextEditingController _controller;
  var screenSize;


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
                          padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.only(left:10, right: 10),
                        height: 40,
                        margin: EdgeInsets.only(top: 88),
                        decoration: _getBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(

                              child: Container(
                                child: Text(baseLanguage.label),
                                alignment: Alignment.center,
                              )
                            ),
                            Expanded(
                                child: Container(
                                  child : FlatButton.icon(
                                    label: Text(''),
                                    icon: Icon(Icons.swap_horiz),
                                    textColor: Colors.black,
                                    onPressed: () => {_reverseLanguage()}
                                  ),
                                  alignment: Alignment.center,
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
                        SizedBox(height: 5),
                        WordInput(
                            controller: _controller,
                            label: translateLanguage.label,
                            onWordChanged: (value) => {_updateTranslateWord(value)},
                        ),
                        SizedBox(height: 5),
                        IconTextButton(
                          width: 90,
                          icon: Icons.save,
                          text: 'Save',
                          onPressed: () {_saveWord();},
                        ),
                        SizedBox(height: 5)
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
    _controller.text = word;
  }

  void _saveWord() async {
    List<String> langs = <String>[_languageService.foreignLanguage.id,_languageService.nativeLanguage.id];
    langs.sort();
    // La ref sera id-id des language trier par l'ordre alphabetic
    String ref = langs[0]+'-'+langs[1];
    User user = _authService.getUser();
    Dictionary data = Dictionary(
        langue1: baseLanguage.label,
        word1: baseWord ,
        langue2: translateLanguage.label,
        word2: _controller.text ,
        score: 0
    );
    _firebaseFirestore.getCollection(user.uid)
        .doc('dictionary')
        .collection(ref)
        .doc()
        .set(data.toJson());
  }

  void _updateBaseWord(value) {
    setState(() {
      baseWord = value;
    });
  }

  void _updateTranslateWord(value) {
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
