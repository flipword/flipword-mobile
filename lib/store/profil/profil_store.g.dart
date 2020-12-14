// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilStore on _ProfilStore, Store {
  final _$courantProfilAtom = Atom(name: '_ProfilStore.courantProfil');

  @override
  UserProfil get courantProfil {
    _$courantProfilAtom.reportRead();
    return super.courantProfil;
  }

  @override
  set courantProfil(UserProfil value) {
    _$courantProfilAtom.reportWrite(value, super.courantProfil, () {
      super.courantProfil = value;
    });
  }

  final _$_ProfilStoreActionController = ActionController(name: '_ProfilStore');

  @override
  void logout() {
    final _$actionInfo =
        _$_ProfilStoreActionController.startAction(name: '_ProfilStore.logout');
    try {
      return super.logout();
    } finally {
      _$_ProfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courantProfil: ${courantProfil}
    ''';
  }
}
