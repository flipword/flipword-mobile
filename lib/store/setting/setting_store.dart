import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';

class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {
  final LanguageService _languageService = LanguageService.instance;

  @observable
  ObservableFuture<List<Language>?> languages = ObservableFuture.value(null);

  @observable
  ObservableFuture<Language?> nativeLanguage = ObservableFuture.value(null);

  @observable
  ObservableFuture<Language?> foreignLanguage = ObservableFuture.value(null);

  @observable
  ObservableFuture<int?> nbSuccessRequired = ObservableFuture.value(null);

  @observable
  Language? baseLanguage;

  @observable
  Language? translateLanguage;

  @computed
  bool get isReverseLanguage => nativeLanguage.value != baseLanguage;

  @action
  Future<void> initLanguages() => _languageService.init().then((_) =>
      languages =
          ObservableFuture(_languageService.getLanguages().then((value) async {
        _setNativeLanguage(_languageService.currentNativeLanguage);
        _setForeignLanguage(_languageService.currentForeignLanguage);
        _languageService
            .refreshLanguage(_languageService.currentNativeLanguage.isoCode!);
        return value;
      })));

  @action
  Future<void> updateNativeLanguage(Language language) =>
      _languageService.updateNativeLanguage(language.isoCode).then((_) {
        _setNativeLanguage(language);
        return;
      });

  @action
  Future<void> updateForeignLanguage(Language language) =>
      _languageService.updateForeignLanguage(language.isoCode).then((value) {
        _setForeignLanguage(language);
        return;
      });

  @action
  void reverseLanguage() {
    final tmp = baseLanguage;
    baseLanguage = translateLanguage;
    translateLanguage = tmp;
  }

  void _setNativeLanguage(Language language) {
    nativeLanguage = ObservableFuture.value(language);
    baseLanguage = language;
  }

  void _setForeignLanguage(Language language) {
    foreignLanguage = ObservableFuture.value(language);
    translateLanguage = language;
  }

  @action
  Future<String?> translate(String? from, String? to, String word) =>
      _languageService.translate(from, to, word);

  @action
  void loadTranslation() =>
      _languageService.refreshLanguage(nativeLanguage.value!.isoCode!);
}
