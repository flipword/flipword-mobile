// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingStore on _SettingStore, Store {
  Computed<bool>? _$isReverseLanguageComputed;

  @override
  bool get isReverseLanguage => (_$isReverseLanguageComputed ??= Computed<bool>(
          () => super.isReverseLanguage,
          name: '_SettingStore.isReverseLanguage'))
      .value;

  final _$languagesAtom = Atom(name: '_SettingStore.languages');

  @override
  ObservableFuture<List<Language>?> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(ObservableFuture<List<Language>?> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  final _$nativeLanguageAtom = Atom(name: '_SettingStore.nativeLanguage');

  @override
  ObservableFuture<Language?> get nativeLanguage {
    _$nativeLanguageAtom.reportRead();
    return super.nativeLanguage;
  }

  @override
  set nativeLanguage(ObservableFuture<Language?> value) {
    _$nativeLanguageAtom.reportWrite(value, super.nativeLanguage, () {
      super.nativeLanguage = value;
    });
  }

  final _$foreignLanguageAtom = Atom(name: '_SettingStore.foreignLanguage');

  @override
  ObservableFuture<Language?> get foreignLanguage {
    _$foreignLanguageAtom.reportRead();
    return super.foreignLanguage;
  }

  @override
  set foreignLanguage(ObservableFuture<Language?> value) {
    _$foreignLanguageAtom.reportWrite(value, super.foreignLanguage, () {
      super.foreignLanguage = value;
    });
  }

  final _$nbSuccessRequiredAtom = Atom(name: '_SettingStore.nbSuccessRequired');

  @override
  ObservableFuture<int?> get nbSuccessRequired {
    _$nbSuccessRequiredAtom.reportRead();
    return super.nbSuccessRequired;
  }

  @override
  set nbSuccessRequired(ObservableFuture<int?> value) {
    _$nbSuccessRequiredAtom.reportWrite(value, super.nbSuccessRequired, () {
      super.nbSuccessRequired = value;
    });
  }

  final _$baseLanguageAtom = Atom(name: '_SettingStore.baseLanguage');

  @override
  ObservableValue<Language?> get baseLanguage {
    _$baseLanguageAtom.reportRead();
    return super.baseLanguage;
  }

  @override
  set baseLanguage(ObservableValue<Language?> value) {
    _$baseLanguageAtom.reportWrite(value, super.baseLanguage, () {
      super.baseLanguage = value;
    });
  }

  final _$translateLanguageAtom = Atom(name: '_SettingStore.translateLanguage');

  @override
  ObservableValue<Language?> get translateLanguage {
    _$translateLanguageAtom.reportRead();
    return super.translateLanguage;
  }

  @override
  set translateLanguage(ObservableValue<Language?> value) {
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
  Future<String?> translate(String? from, String? to, String word) {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.translate');
    try {
      return super.translate(from, to, word);
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadTranslation() {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.loadTranslation');
    try {
      return super.loadTranslation();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
languages: ${languages},
nativeLanguage: ${nativeLanguage},
foreignLanguage: ${foreignLanguage},
nbSuccessRequired: ${nbSuccessRequired},
baseLanguage: ${baseLanguage},
translateLanguage: ${translateLanguage},
isReverseLanguage: ${isReverseLanguage}
    ''';
  }
}
