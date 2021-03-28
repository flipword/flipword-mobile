import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';


class SettingStore = _SettingStore with _$SettingStore;


abstract class _SettingStore with Store {

  final LanguageService _languageService = LanguageService.instance;

  @observable
  ObservableFuture<Language> nativeLanguage = ObservableFuture.value(null);

  @observable
  ObservableFuture<Language> foreignLanguage = ObservableFuture.value(null);

  @action
  Future<void> load() =>
      Future.wait([
        loadNativeLanguage(),
        loadForeignLanguage()
      ]);

  @action
  Future<void> loadNativeLanguage() =>
      nativeLanguage = ObservableFuture(_languageService.getCurrentNativeLanguage().then((value) => value));

  @action
  Future<void> loadForeignLanguage() =>
      foreignLanguage = ObservableFuture(_languageService.getCurrentForeignLanguage().then((value) => value));

}