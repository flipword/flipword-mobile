// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilStore on _ProfilStore, Store {
  final _$currentProfileAtom = Atom(name: '_ProfilStore.currentProfile');

  @override
  ObservableFuture<UserProfil?> get currentProfile {
    _$currentProfileAtom.reportRead();
    return super.currentProfile;
  }

  @override
  set currentProfile(ObservableFuture<UserProfil?> value) {
    _$currentProfileAtom.reportWrite(value, super.currentProfile, () {
      super.currentProfile = value;
    });
  }

  final _$_ProfilStoreActionController = ActionController(name: '_ProfilStore');

  @override
  Future<void> logout() {
    final _$actionInfo =
        _$_ProfilStoreActionController.startAction(name: '_ProfilStore.logout');
    try {
      return super.logout();
    } finally {
      _$_ProfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> login(SignInMethod signInMethod) {
    final _$actionInfo =
        _$_ProfilStoreActionController.startAction(name: '_ProfilStore.login');
    try {
      return super.login(signInMethod);
    } finally {
      _$_ProfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_ProfilStoreActionController.startAction(
        name: '_ProfilStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_ProfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentProfile: ${currentProfile}
    ''';
  }
}
