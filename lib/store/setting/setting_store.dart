import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';


class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {

  final LanguageService _languageService = LanguageService.instance;

  @observable
  ObservableFuture<List<Language>> languages = ObservableFuture.value(null);

  @computed
  ObservableFuture<Language> get nativeLanguage => ObservableFuture.value(_languageService.currentNativeLanguage);

  @computed
  ObservableFuture<Language> get foreignLanguage => ObservableFuture.value(_languageService.currentForeignLanguage);

  @observable
  Language baseLanguage;

  @observable
  Language translateLanguage;

  @action
  Future<void> initLanguages() =>
      _languageService.init().then((_) =>
        languages = ObservableFuture(_languageService.getLanguages().then((value){
          baseLanguage = _languageService.currentNativeLanguage;
          translateLanguage = _languageService.currentForeignLanguage;
          return value;
          })));

  @action
  Future<void> updateNativeLanguage(Language language) => _languageService.updateNativeLanguage(language.isoCode).then((_) =>
    baseLanguage = language);

  @action
  Future<void> updateForeignLanguage(Language language) =>_languageService.updateForeignLanguage(language.isoCode).then((value) =>
    translateLanguage = language);

  @action
  void reverseLanguage(){
    final tmp = baseLanguage;
    baseLanguage = translateLanguage;
    translateLanguage = tmp;
  }
}