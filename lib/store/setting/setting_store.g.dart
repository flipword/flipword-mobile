// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingStore on _SettingStore, Store {
  final _$nativeLanguageAtom = Atom(name: '_SettingStore.nativeLanguage');

  @override
  ObservableFuture<Language> get nativeLanguage {
    _$nativeLanguageAtom.reportRead();
    return super.nativeLanguage;
  }

  @override
  set nativeLanguage(ObservableFuture<Language> value) {
    _$nativeLanguageAtom.reportWrite(value, super.nativeLanguage, () {
      super.nativeLanguage = value;
    });
  }

  final _$foreignLanguageAtom = Atom(name: '_SettingStore.foreignLanguage');

  @override
  ObservableFuture<Language> get foreignLanguage {
    _$foreignLanguageAtom.reportRead();
    return super.foreignLanguage;
  }

  @override
  set foreignLanguage(ObservableFuture<Language> value) {
    _$foreignLanguageAtom.reportWrite(value, super.foreignLanguage, () {
      super.foreignLanguage = value;
    });
  }

  final _$_SettingStoreActionController =
      ActionController(name: '_SettingStore');

  @override
  Future<void> load() {
    final _$actionInfo =
        _$_SettingStoreActionController.startAction(name: '_SettingStore.load');
    try {
      return super.load();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadNativeLanguage() {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.loadNativeLanguage');
    try {
      return super.loadNativeLanguage();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadForeignLanguage() {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.loadForeignLanguage');
    try {
      return super.loadForeignLanguage();
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nativeLanguage: ${nativeLanguage},
foreignLanguage: ${foreignLanguage}
    ''';
  }
}
