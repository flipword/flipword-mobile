import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';


class SettingStore = _SettingStore with _$SettingStore;

// TODO: use languages loaded to get native/foreign language
abstract class _SettingStore with Store {

  final LanguageService _languageService = LanguageService.instance;

  @observable
  ObservableFuture<List<Language>> languages = ObservableFuture.value(null);

  @observable
  ObservableFuture<Language> nativeLanguage = ObservableFuture.value(null);

  @observable
  ObservableFuture<Language> foreignLanguage = ObservableFuture.value(null);

  @observable
  Language baseLanguage;

  @observable
  Language translateLanguage;

  @action
  Future<void> load() =>
      Future.wait([
        loadLanguages(),
        loadNativeLanguage(),
        loadForeignLanguage()
      ]);

  @action
  Future<void> loadLanguages() =>
      languages = ObservableFuture(_languageService.getLanguages().then((value) => value));

  @action
  Future<void> loadNativeLanguage() =>
      nativeLanguage = ObservableFuture(_languageService.getCurrentNativeLanguage().then((value) => baseLanguage = value));

  @action
  Future<void> loadForeignLanguage() =>
      foreignLanguage = ObservableFuture(_languageService.getCurrentForeignLanguage().then((value) => translateLanguage = value));

  @action
  Future<void> updateNativeLanguage(Language language) =>
      nativeLanguage = ObservableFuture(_languageService.updateNativeLanguage(language.isoCode).then((_) {
        baseLanguage = language;
        return language;
      }));

  @action
  Future<void> updateForeignLanguage(Language language) =>
      foreignLanguage = ObservableFuture(_languageService.updateForeignLanguage(language.isoCode).then((_){
        translateLanguage = language;
        return language;
      }));

  @action
  void reverseLanguage(){
    final tmp = baseLanguage;
    baseLanguage = translateLanguage;
    translateLanguage = tmp;
  }
}