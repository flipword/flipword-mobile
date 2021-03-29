// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingStore on _SettingStore, Store {
  Computed<ObservableFuture<Language>> _$nativeLanguageComputed;

  @override
  ObservableFuture<Language> get nativeLanguage => (_$nativeLanguageComputed ??=
          Computed<ObservableFuture<Language>>(() => super.nativeLanguage,
              name: '_SettingStore.nativeLanguage'))
      .value;
  Computed<ObservableFuture<Language>> _$foreignLanguageComputed;

  @override
  ObservableFuture<Language> get foreignLanguage =>
      (_$foreignLanguageComputed ??= Computed<ObservableFuture<Language>>(
              () => super.foreignLanguage,
              name: '_SettingStore.foreignLanguage'))
          .value;

  final _$languagesAtom = Atom(name: '_SettingStore.languages');

  @override
  ObservableFuture<List<Language>> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(ObservableFuture<List<Language>> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  final _$baseLanguageAtom = Atom(name: '_SettingStore.baseLanguage');

  @override
  Language get baseLanguage {
    _$baseLanguageAtom.reportRead();
    return super.baseLanguage;
  }

  @override
  set baseLanguage(Language value) {
    _$baseLanguageAtom.reportWrite(value, super.baseLanguage, () {
      super.baseLanguage = value;
    });
  }

  final _$translateLanguageAtom = Atom(name: '_SettingStore.translateLanguage');

  @override
  Language get translateLanguage {
    _$translateLanguageAtom.reportRead();
    return super.translateLanguage;
  }

  @override
  set translateLanguage(Language value) {
    _$translateLanguageAtom.reportWrite(value, super.translateLanguage, () {
      super.translateLanguage = value;
    });
  }

  final _$_SettingStoreActionController =
      ActionController(name: '_SettingStore');

  @override
  Future<void> initLanguages() {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.initLanguages');
    try {
      return super.initLanguages();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> updateNativeLanguage(Language language) {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.updateNativeLanguage');
    try {
      return super.updateNativeLanguage(language);
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> updateForeignLanguage(Language language) {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.updateForeignLanguage');
    try {
      return super.updateForeignLanguage(language);
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reverseLanguage() {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.reverseLanguage');
    try {
      return super.reverseLanguage();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
languages: ${languages},
baseLanguage: ${baseLanguage},
translateLanguage: ${translateLanguage},
nativeLanguage: ${nativeLanguage},
foreignLanguage: ${foreignLanguage}
    ''';
  }
}
