import 'package:flutter_flip_card/services/language_service.dart';
import 'package:language_pickers/languages.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';


class SettingStore = _SettingStore with _$SettingStore;


abstract class _SettingStore with Store {

  final LanguageService _languageService = LanguageService.instance;
  @observable
  Language nativeLanguage = LanguageService.instance.nativeLanguage;

  @observable
  Language foreignLanguage = LanguageService.instance.foreignLanguage;

  @action
  void updateNativeLanguage(Language language){
    _languageService.nativeLanguage = language;
    nativeLanguage =  language;
  }

  @action
  void updateForeignLanguage(Language language){
    _languageService.foreignLanguage = language;
    foreignLanguage = language;
  }

  String  getRef()  => '${nativeLanguage.isoCode}-${foreignLanguage.isoCode}';

}