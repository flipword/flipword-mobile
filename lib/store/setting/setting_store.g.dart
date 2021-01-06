// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingStore on _SettingStore, Store {
  Computed<Language> _$getNativeLanguageComputed;

  @override
  Language get getNativeLanguage => (_$getNativeLanguageComputed ??=
          Computed<Language>(() => super.getNativeLanguage,
              name: '_SettingStore.getNativeLanguage'))
      .value;
  Computed<Language> _$getForeignLanguageComputed;

  @override
  Language get getForeignLanguage => (_$getForeignLanguageComputed ??=
          Computed<Language>(() => super.getForeignLanguage,
              name: '_SettingStore.getForeignLanguage'))
      .value;

  final _$nativeLanguageAtom = Atom(name: '_SettingStore.nativeLanguage');

  @override
  Language get nativeLanguage {
    _$nativeLanguageAtom.reportRead();
    return super.nativeLanguage;
  }

  @override
  set nativeLanguage(Language value) {
    _$nativeLanguageAtom.reportWrite(value, super.nativeLanguage, () {
      super.nativeLanguage = value;
    });
  }

  final _$foreignLanguageAtom = Atom(name: '_SettingStore.foreignLanguage');

  @override
  Language get foreignLanguage {
    _$foreignLanguageAtom.reportRead();
    return super.foreignLanguage;
  }

  @override
  set foreignLanguage(Language value) {
    _$foreignLanguageAtom.reportWrite(value, super.foreignLanguage, () {
      super.foreignLanguage = value;
    });
  }

  final _$_SettingStoreActionController =
      ActionController(name: '_SettingStore');

  @override
  void updateNativeLanguage(Language language) {
    final _$actionInfo = _$_SettingStoreActionController.startAction(
        name: '_SettingStore.updateNativeLanguage');
    try {
      return super.updateNativeLanguage(language);
    } finally {
      _$_SettingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateForeignLanguage(Language language) {
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
nativeLanguage: ${nativeLanguage},
foreignLanguage: ${foreignLanguage},
getNativeLanguage: ${getNativeLanguage},
getForeignLanguage: ${getForeignLanguage}
    ''';
  }
}
